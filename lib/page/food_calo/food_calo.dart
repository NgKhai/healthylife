import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthylife/model/CaloHistory.dart';
import 'package:healthylife/page/calo/calo_page.dart';
import 'package:healthylife/util/color_theme.dart';
import 'package:healthylife/widget/food_calo/food_calo_widget.dart';
import 'package:intl/intl.dart';

import '../../model/Food.dart';
import '../../model/FoodCategory.dart';

class FoodCaloPage extends StatefulWidget {
  const FoodCaloPage({super.key});

  @override
  State<FoodCaloPage> createState() => _FoodCaloState();
}

class _FoodCaloState extends State<FoodCaloPage> {
  int _selectIndex = 0;

  bool _isLoading = false;

  late List<FoodCategory> categories = [];
  late List<Food> foods = [];
  late List<bool> _selectStates = [];

  late List<Food> filteredFoods = [];

  late List<String> foodHistoryList = [];

  num value = 0;

  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  bool isChecked() {
    return _selectStates.contains(true);
  }

  void fetchData() async {
    setState(() {
      _isLoading = true;
    });
    await getFoodCategory();
    await getFood();
    _selectStates = List.generate(foods.length, (index) => false);

    setState(() {
      _isLoading = false;
    });

    _searchController.clear();

    _selectIndex = 0;
    value = 0;
  }

  // hàm lấy dữ liệu loại thức ăn từ firebase
  Future<void> getFoodCategory() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('FoodCategory').get();
    setState(() {
      categories = querySnapshot.docs
          .map((doc) => FoodCategory.fromFirestore(doc))
          .toList();
    });
  }

  // hàm lấy dữ liệu Food từ firebase
  Future<void> getFood() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Food')
        // .orderBy("FoodName")
        .get();
    setState(() {
      foods = querySnapshot.docs.map((doc) => Food.fromFirestore(doc)).toList();
    });
  }

  Future<void> searchFoodByName(String name) async {
    setState(() {
      filteredFoods = foods
          .where((food) =>
              food.FoodName.toLowerCase().contains(name.toLowerCase()))
          .toList();
      _selectStates = List.generate(filteredFoods.length, (index) => false);
    });
  }

  void getFoodsForCategory(String categoryFood) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Food')
        .where('FoodCategoryID', isEqualTo: categoryFood)
        .get();
    setState(() {
      foods = querySnapshot.docs.map((doc) => Food.fromFirestore(doc)).toList();
    });
  }

  Future<void> addCaloHistory(List<String> foodHistory) async {
    try {

      DateTime now = DateTime.now();
      String formattedDate = DateFormat('dd/MM/yyyy').format(now);

      final caloHistoryCollection =
          FirebaseFirestore.instance.collection('CaloHistory');

      final querySnapshot = await caloHistoryCollection
          .where('UserID', isEqualTo: 'lCIdlGoR2V2HPOEOFkF9')
          .where('DateHistory', isEqualTo: formattedDate)
          .get();

      if(querySnapshot.docs.isNotEmpty) {
        final document = querySnapshot.docs.first;

        CaloHistory caloHistory = CaloHistory(document.id, 'lCIdlGoR2V2HPOEOFkF9', formattedDate, foodHistoryList);

        final existingFoodHistory = List<String>.from(document.data()['FoodID'] ?? []);

        existingFoodHistory.addAll(foodHistoryList);

        // await caloHistoryCollection.doc(document.id).update({
        //   'FoodHistory': existingFoodHistory.map((food) => food.toJson()).toList(),
        // });

        await caloHistoryCollection
            .doc(document.id)
            .update({
          'FoodID': existingFoodHistory,
        })
            .then((value) {
          print("Calo history update\nUID:${caloHistory.CaloHistoryID}");
          Navigator.pop(context);
        }).catchError((error) => print("Failed to update calo history: $error"));

      } else {
        final uid = caloHistoryCollection.doc().id;

        CaloHistory caloHistory = CaloHistory(uid, 'lCIdlGoR2V2HPOEOFkF9', formattedDate, foodHistory);

        await caloHistoryCollection
            .doc(caloHistory.CaloHistoryID)
            .set(caloHistory.toJson())
            .then((value) {
          print("Calo history Added\nUID:${caloHistory.CaloHistoryID}");
          Navigator.pop(context);
        }).catchError((error) => print("Failed to add calo history: $error"));
      }


    } on Exception catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          color: Colors.white,
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Món ăn của bạn'),
        titleTextStyle: GoogleFonts.getFont(
          'Montserrat',
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        backgroundColor: ColorTheme.lightGreenColor,
        bottom: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.06),
          child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Tìm kiếm...',
                        hintStyle: GoogleFonts.getFont(
                          'Montserrat',
                          fontSize: 13,
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.zero,
                        prefixIcon: Icon(Icons.search),
                      ),
                      onChanged: (value) {
                        // Khi nội dung thanh tìm kiếm thay đổi
                        // Thực hiện hành động tìm kiếm ở đây
                        searchFoodByName(value);
                      },
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    color: Colors.white,
                    onPressed: () {},
                  ),
                ],
              )),
        ),
      ),
      body: _isLoading
          ? Center(
              child:
                  CircularProgressIndicator(), // Show loading indicator while fetching data
            )
          : RefreshIndicator(
              onRefresh: () async => fetchData(),
              child: Container(
                color: Colors.grey.shade100,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.08,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                          itemCount: categories.length + 1,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (index == 0) {
                                    //  hiển thị tất cả sản phẩm
                                    _selectIndex = 0;
                                    getFood();
                                  } else {
                                    _selectIndex = index;
                                    getFoodsForCategory(
                                        categories[index - 1].FoodCategoryID ??
                                            '');
                                  }
                                });
                              },
                              child: AnimatedContainer(
                                duration: const Duration(microseconds: 300),
                                margin: EdgeInsets.all(5),
                                width: MediaQuery.of(context).size.width * 0.25,
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                decoration: BoxDecoration(
                                  color: _selectIndex == index
                                      ? Colors.grey.shade50
                                      : Colors.white,
                                  border: _selectIndex == index
                                      ? Border.all(
                                          color: Colors.redAccent, width: 3)
                                      : null,
                                  borderRadius: _selectIndex == index
                                      ? BorderRadius.circular(15)
                                      : BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    index == 0
                                        ? "Tất cả"
                                        : categories[index - 1]
                                                .FoodCategoryName ??
                                            "",
                                    style: GoogleFonts.getFont('Montserrat',
                                        fontWeight: FontWeight.bold,
                                        color: _selectIndex == index
                                            ? Colors.black
                                            : Colors.grey),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          _searchController.text.isEmpty
                              ? listItem(foods)
                              : listItem(filteredFoods),
                          if (isChecked())
                            Padding(
                              padding: EdgeInsets.only(
                                  bottom: MediaQuery.of(context).size.height *
                                      0.025),
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 2 / 3,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.all(15),
                                      backgroundColor:
                                          ColorTheme.backgroundColor,
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                    onPressed: () {
                                      addCaloHistory(foodHistoryList);
                                    },
                                    child: Text(
                                      'Thêm ngay - $value calo',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget listItem(List<Food> foods) {
    return Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(6),
        alignment: Alignment.center,
        child: ListView.builder(
            itemCount: foods.length,
            itemBuilder: (context, index) {
              return Container(
                  padding: const EdgeInsets.all(6),
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.network(
                        width: 50,
                        height: 50,
                        foods[index].FoodImage ?? "",
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.image),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            foods[index].FoodName ?? "",
                            style: GoogleFonts.getFont('Montserrat',
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "100g - ${foods[index].FoodCalo} calo",
                            style: GoogleFonts.getFont(
                              'Montserrat',
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            print(_selectStates[index]);
                            _selectStates[index] = !_selectStates[
                                index]; // chuyển đồi trạng thái khi chọn icon

                            value += !_selectStates[index]
                                ? -foods[index].FoodCalo
                                : foods[index].FoodCalo;

                            _selectStates[index] ? foodHistoryList.add(foods[index].FoodID) : foodHistoryList.removeAt(index);

                            print(_selectStates[index]);
                            // print()
                            print(foodHistoryList);
                          });
                          print("Value: " + value.toString());
                        },
                        icon: Icon(
                          _selectStates[index]
                              ? Icons.check_circle_rounded
                              : Icons.add_circle_outline,
                          color:
                              _selectStates[index] ? Colors.green : Colors.grey,
                          size: 30,
                        ),
                      ),
                    ],
                  ));
            }));
  }
}
