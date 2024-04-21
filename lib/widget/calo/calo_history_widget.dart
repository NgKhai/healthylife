import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthylife/model/CaloHistory.dart';
import 'package:healthylife/util/color_theme.dart';

import '../../model/Food.dart';
import '../../util/snack_bar_error_mess.dart';

class CaloHistoryWidget extends StatefulWidget {
  String userID;
  String dateHistory;

  CaloHistoryWidget({required this.userID, required this.dateHistory});

  @override
  State<CaloHistoryWidget> createState() => _CaloHistoryWidgetState();
}

class _CaloHistoryWidgetState extends State<CaloHistoryWidget> {
  List<String> foodHistories = [];
  List<Food> foods = [];
  bool isLoading = true;
  Future<void>? _dataLoadingFuture;

  @override
  void initState() {
    super.initState();
    _dataLoadingFuture = fetchData();
  }

  @override
  void didUpdateWidget(CaloHistoryWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.userID != oldWidget.userID || widget.dateHistory != oldWidget.dateHistory) {

      _dataLoadingFuture = fetchData(); // Fetch data again if userID or dateHistory changes
    }
  }

  Future<void> fetchData() async {

    setState(() {
      isLoading = true;
      foodHistories.clear();
      foods.clear();
    });

    // Lấy dữ liệu từ Food History
    await getFoodHistory(widget.userID, widget.dateHistory);

    // Nếu có dữ liệu tiến hành lấy thông tin Food từ FoodID đã lấy từ Food History
    if (foodHistories.isNotEmpty) {
      await getFood();
    }
    setState(() {
      isLoading = false;


    });
  }

  // Hàm lấy dữ liệu CaloHistory
  Future<void> getFoodHistory(String userID, String dateHistory) async {
    try {

      // lấy dữ liệu CaloHistory thông qua userID và date history
      final caloHistoryQuerySnapshot = await FirebaseFirestore.instance
          .collection('CaloHistory')
          .where('UserID', isEqualTo: userID)
          .where('DateHistory', isEqualTo: dateHistory)
          .get();

      // Nếu dữ liệu tồn tại
      if (caloHistoryQuerySnapshot.docs.isNotEmpty) {

        // lấy id document
        final document = caloHistoryQuerySnapshot.docs.first;

        // lấy List dữ liệu FoodID và truyền vào tham số foodHistories
        foodHistories = List<String>.from(document.data()['FoodID'] ?? []);

      // Nếu dữ liệu chưa có sẽ tạo rỗng
      } else {
        foodHistories = [];
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  Future<void> getFood() async {
    List<Food> fetchedFoods = [];
    for (String foodID in foodHistories) {
      final foodDocSnapshot = await FirebaseFirestore.instance
          .collection('Food')
          .doc(foodID)
          .get();

      if (foodDocSnapshot.exists) {
        Food foodItem = Food.fromFirestore(foodDocSnapshot);
        fetchedFoods.add(foodItem);
      }
    }
    setState(() {
      foods = fetchedFoods;
    });
  }

  Future<void> removeFood(int index) async {
    final caloHistoryQuerySnapshot = await FirebaseFirestore.instance
        .collection('CaloHistory')
        .where('UserID', isEqualTo: widget.userID)
        .where('DateHistory', isEqualTo: widget.dateHistory)
        .get();

    if (caloHistoryQuerySnapshot.docs.isNotEmpty) {
      final document = caloHistoryQuerySnapshot.docs.first;

      String foodIDToRemove = foodHistories[index];

      await FirebaseFirestore.instance
          .collection('CaloHistory')
          .doc(document.id)
          .update({
        'FoodID': FieldValue.arrayRemove([foodIDToRemove])
      });

      SnackBarErrorMess.show(context, 'Xóa ${foods[index].FoodName} thành công!');

      setState(() {
        foodHistories.removeAt(index);
        foods.removeAt(index);
      });


    } else {
      SnackBarErrorMess.show(context, 'Không thể tìm thấy lịch sử calo.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _dataLoadingFuture,
      builder: (context, snapshot) {

        // Check dữ liệu đã nạp xong chưa
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text(
            'Lỗi dữ liệu, vui lòng thử lại',
            style: GoogleFonts.getFont(
              'Montserrat',
              color: Colors.grey,
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),);
        } else if(foods.isEmpty) {
          return Center(child: Text(
            'Bạn đã ăn gì? Hãy bổ sung calo ngay!',
            style: GoogleFonts.getFont(
              'Montserrat',
              color: Colors.grey,
              fontWeight: FontWeight.normal,
              fontSize: 16,
            ),
          ),);
        }
        else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Nạp calo",
                style: GoogleFonts.getFont('Montserrat', fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: foods.length,
                itemBuilder: (context, index) {
                  if (index >= foods.length) {
                    // Trả về empty widget khi index > range
                    return SizedBox.shrink();
                  }

                  final food = foods[index];
                  return Dismissible(
                    key: Key(food.FoodID),
                    direction: DismissDirection.endToStart,
                    // Kéo sang phải đề remove dữ liệu
                    onDismissed: (direction) {
                      removeFood(index);
                    },
                    background: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(
                          colors: [ColorTheme.darkGreenColor, ColorTheme.lightGreenColor],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                      alignment: Alignment.centerRight,
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                    child: buildFoodItem(food, index), // Widget hiển thị các item food
                  );
                },
              ),
            ],
          );
        }
      },
    );
  }

  Widget buildFoodItem(Food food, int index) {
    return Container(
      padding: const EdgeInsets.all(6),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.network(
            food.FoodImage ?? "",
            width: 50,
            height: 50,
            errorBuilder: (context, error, stackTrace) => const Icon(Icons.image),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                food.FoodName ?? "",
                style: GoogleFonts.getFont('Montserrat', fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                "100g - ${food.FoodCalo} calo",
                style: GoogleFonts.getFont('Montserrat', fontSize: 16, color: Colors.grey),
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              setState(() {
                removeFood(index);
              });
              SnackBarErrorMess.show(context, 'Xóa ${food.FoodName} thành công!');
            },
            icon: Icon(
              Icons.remove_circle_outline,
              color: Colors.grey,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}
