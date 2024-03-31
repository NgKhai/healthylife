
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class FoodCaloPage extends StatefulWidget{
  const FoodCaloPage({super.key});

  @override
  State<FoodCaloPage> createState() => _FoodCaloState();
}

class _FoodCaloState extends State<FoodCaloPage>{
  List<String?> categoryID = [];
  List<String?> categoryName = [];
  List<String?> foodName = [];
  List<String?> foodImage = [];
  List<int?> foodCalo = [];
  int _selectIndex = 0;
  bool _selectState = false;



  @override
  void initState(){
    super.initState();
    getFoodCategory();
    getFood();
    //getFoodImage();
  }

  // hàm lấy dữ liệu loại thức ăn từ firebase
  void getFoodCategory() async{
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('FoodCategory').get();
    setState(() {
      categoryID = querySnapshot.docs.map((doc) => doc['FoodCategoryID'] as String?).toList();
      categoryName = querySnapshot.docs.map((doc) => doc['FoodCategoryName'] as String?).toList();
    });
  }
  // hàm lấy dữ liệu Food từ firebase
  void getFood() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Food').get();
    setState(() {
      foodName = querySnapshot.docs.map((doc) => doc['FoodName'] as String?).toList();
      foodImage = querySnapshot.docs.map((doc) => doc['FoodImage'] as String?).toList();
      foodCalo = querySnapshot.docs.map((doc) => doc['FoodCalo'] as int?).toList();
    });
  }

  void getAllFood() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Food').get();

  }
  void getFoodsForCategory(String categoryFood) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Food')
        .where('FoodCategoryID', isEqualTo: categoryFood)
        .get();
    setState(() {
      foodName = querySnapshot.docs.map((doc) => doc['FoodName'] as String?).toList();
      foodImage = querySnapshot.docs.map((doc) => doc['FoodImage'] as String?).toList();
      foodCalo = querySnapshot.docs.map((doc) => doc['FoodCalo'] as int?).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Món ăn của bạn'),
        titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 26
        ),
        backgroundColor: Color(0xFFDE5044),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(40),
          child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Tìm kiếm...',
                        hintStyle: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
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
                  SizedBox(width: MediaQuery.of(context).size.width * 0.0,),
                  IconButton(
                    icon: Icon(Icons.add),
                    color: Colors.white,
                    onPressed: () {},
                  ),
                ],
              )
          ),
        ),
      ),
      body: Container(
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
                  itemCount: categoryName.length + 1,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index){
                    return GestureDetector(
                      onTap: (){
                        setState(() {
                          if(index == 0){
                            //  hiển thị tất cả sản phẩm
                            _selectIndex = 0;
                            getFood();
                          }
                          else{
                            _selectIndex = index;
                            getFoodsForCategory(categoryID[index - 1] ?? '');
                          }
                        });

                      },
                      child: AnimatedContainer(
                        duration: const Duration(microseconds: 300),
                        margin: EdgeInsets.all(5),
                        width: MediaQuery.of(context).size.height * 0.1,
                        height: MediaQuery.of(context).size.height * 0.07,
                        decoration: BoxDecoration(
                          color: _selectIndex == index
                              ? Colors.grey.shade50
                              : Colors.white,
                          border: _selectIndex == index
                              ? Border.all(color: Colors.redAccent, width: 3)
                              : null,
                          borderRadius: _selectIndex == index
                              ? BorderRadius.circular(15)
                              : BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(index == 0 ? "Tất cả" : categoryName[index - 1] ?? "",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: _selectIndex == index
                                    ? Colors.black : Colors.grey
                            ),
                          ),
                        ),
                      ),
                    );
                  }
              ),
            ),
            Expanded(
              child: Container(
                //color: Colors.red,
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.all(6),
                alignment: Alignment.center,
                child: ListView.builder(
                    itemCount: foodName.length,
                    itemBuilder: (context, index){
                      return Container(
                        //height: 900,
                          padding: const EdgeInsets.all(6),
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                foodImage[index] ?? "",
                                // height: 50,
                                // width: 50,
                                errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.image),
                              ),
                              SizedBox(width: 30,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(foodName[index] ?? "",
                                    style: const TextStyle(
                                        fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                  Text("100g - ${foodCalo[index]} calo" ,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    _selectState = !_selectState;  // chuyển đồi trạng thái khi chọn icon
                                  });
                                },
                                icon: Icon( _selectState
                                    ? Icons.check_circle_rounded
                                    : Icons.add_circle_outline,
                                  color: _selectState ? Colors.green : Colors.grey,
                                  size: 30,
                                ),
                              ),
                            ],
                          )
                      );
                    }
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }

}