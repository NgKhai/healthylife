import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthylife/page/calo/calo_page.dart';
import 'package:healthylife/util/color_theme.dart';
import 'package:healthylife/widget/food_calo/food_calo_widget.dart';

import '../../model/Food.dart';
import '../../model/FoodCategory.dart';

class FoodCaloPage extends StatefulWidget {
  const FoodCaloPage({super.key});

  @override
  State<FoodCaloPage> createState() => _FoodCaloState();
}

class _FoodCaloState extends State<FoodCaloPage> {
  int _selectIndex = 0;

  // bool _selectState = false;
  bool _isLoading = false;

  late List<FoodCategory> categories = [];
  late List<Food> foods = [];
  late List<bool> _selectStates = [];

  num value = 0;

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
        .orderBy("FoodName")
        .get();
    setState(() {
      foods = querySnapshot.docs.map((doc) => Food.fromFirestore(doc)).toList();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Món ăn của bạn'),
        titleTextStyle: GoogleFonts.getFont(
          'Montserrat',
          fontWeight: FontWeight.bold,
          fontSize: 26,
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
                          Container(
                            height: MediaQuery.of(context).size.height,
                            padding: EdgeInsets.all(6),
                            alignment: Alignment.center,
                            child: ListView.builder(
                                itemCount: foods.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                      //height: 900,
                                      padding: const EdgeInsets.all(6),
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Image.network(
                                            width: 50,
                                            height: 50,
                                            foods[index].FoodImage ?? "",
                                            errorBuilder:
                                                (context, error, stackTrace) =>
                                                    const Icon(Icons.image),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                foods[index].FoodName ?? "",
                                                style: GoogleFonts.getFont(
                                                    'Montserrat',
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                                _selectStates[index] =
                                                    !_selectStates[
                                                        index]; // chuyển đồi trạng thái khi chọn icon
                                                value += !_selectStates[index]
                                                    ? -foods[index].FoodCalo
                                                    : foods[index].FoodCalo;
                                              });
                                              print(
                                                  "Value: " + value.toString());
                                            },
                                            icon: Icon(
                                              _selectStates[index]
                                                  ? Icons.check_circle_rounded
                                                  : Icons.add_circle_outline,
                                              color: _selectStates[index]
                                                  ? Colors.green
                                                  : Colors.grey,
                                              size: 30,
                                            ),
                                          ),
                                        ],
                                      ));
                                }),
                          ),
                          if (isChecked())
                            Padding(
                              padding: EdgeInsets.only(
                                  bottom: MediaQuery.of(context).size.height *
                                      0.025),
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width * 1/2,
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
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'Thêm ngay'.toUpperCase(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
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
}
