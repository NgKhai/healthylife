import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FoodCaloPage extends StatefulWidget{
  const FoodCaloPage({super.key});

  @override
  State<FoodCaloPage> createState() => _FoodCaloState();
}

class _FoodCaloState extends State<FoodCaloPage>{
  List<String> items = [
    "Tất cả",
    "Hải sản",
    "Rau củ",
    "Trái cây",
    "Thịt",
    "Trứng",
  ];
  int _selectIndex = 0;

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
          height: MediaQuery.of(context).size.height * 0.1,
          width: MediaQuery.of(context).size.height,
          margin: EdgeInsets.all(5),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.07,
                width: MediaQuery.of(context).size.height,
                child: ListView.builder(
                    itemCount: items.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index){
                      return GestureDetector(
                        onTap: (){
                          setState(() {
                            _selectIndex = index;
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
                          child: Text(items[index],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: _selectIndex == index
                                ? Colors.black : Colors.grey
                            ),
                          ),
                        ),
                      ),
                      );
                    }),
              )
            ],
          ),
        ),
      );


      // body: CustomScrollView(
      //   slivers: [
      //     SliverAppBar(
      //       title: Text('Món ăn của bạn'),
      //         titleTextStyle: TextStyle(
      //             fontWeight: FontWeight.bold,
      //             fontSize: 26
      //         ),
      //       backgroundColor: Color(0xFFDE5044),
      //       bottom: PreferredSize(
      //         preferredSize: Size.fromHeight(40),
      //         child: Padding(
      //             padding: EdgeInsets.all(10),
      //             child: Row(
      //               children: [
      //                 Expanded(
      //                   child: TextField(
      //                     decoration: InputDecoration(
      //                       hintText: 'Tìm kiếm...',
      //                       hintStyle: const TextStyle(
      //                         fontSize: 12,
      //                         color: Colors.grey,
      //                       ),
      //                       filled: true,
      //                       fillColor: Colors.white,
      //                       border: OutlineInputBorder(
      //                         borderRadius: BorderRadius.circular(30),
      //                         borderSide: BorderSide.none,
      //                       ),
      //                       contentPadding: EdgeInsets.zero,
      //                       prefixIcon: Icon(Icons.search),
      //                     ),
      //                     onChanged: (value) {
      //                       //
      //                     },
      //                   ),
      //                 ),
      //                 SizedBox(width: MediaQuery.of(context).size.width * 0.0,),
      //                 IconButton(
      //                   icon: Icon(Icons.add),
      //                   color: Colors.white,
      //                   onPressed: () {},
      //                 ),
      //               ],
      //             )
      //         ),
      //       ),
      //     ),
      //
      //     SliverList(
      //         delegate: SliverChildBuilderDelegate(
      //             (BuildContext context, int index) {
      //               return Container(
      //                 height: double.infinity,
      //                 width: double.infinity,
      //                 margin: EdgeInsets.all(5),
      //                 child: Column(
      //                   children: [
      //                     SizedBox(
      //                       height: 60,
      //                       width: double.infinity,
      //                       child: ListView.builder(
      //                           scrollDirection: Axis.horizontal,
      //                           itemBuilder: (context, index){
      //                        return Container(
      //                          margin: EdgeInsets.all(5),
      //                          width: 80,
      //                          height: 45,
      //                          decoration: BoxDecoration(
      //                            color: Colors.red,
      //                          ),
      //                          child: Center(
      //                            child: Text(items[index],
      //                            ),
      //                          ),
      //                        );
      //                       }),
      //                     )
      //                   ],
      //                 ),
      //               );
      //             }
      //         ),
      //     ),
      //   ],
      // ),


  }

}