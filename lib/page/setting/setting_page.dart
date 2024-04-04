import 'dart:convert';
import 'package:healthylife/widget/setting/height_chart_widget.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widget/setting/weight_chart_widget.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool showChart = false;

  // late SharedPreferences logindata;
  //
  // String avatar = "";
  // String username = "";
  // String dob = "";
  // String address = "";
  // String phone = "";
  // String gender = "";
  // String email = "";
  //
  // bool login = false;
  //
  // //switch
  // bool _nofication = false;

  //

  @override
  void initState() {
    super.initState();
    initial();
  }

  void initial() async {
    // logindata = await SharedPreferences.getInstance();
    //
    // login = logindata.getBool('login') ?? false;
    // avatar = await logindata.getString('avatar') ?? "";
    // username = await logindata.getString('username') ?? "";
    // dob = await logindata.getString('dob') ?? "";
    // address = await logindata.getString('address') ?? "";
    // phone = await logindata.getString('phone') ?? "";
    // gender = await logindata.getString('gender') ?? "";
    // email = await logindata.getString('email') ?? "";



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Visibility(
                //visible: login == true,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * (1 / 16),
                  ),
                  child: InkWell(
                    onTap: () {print('Gắn trang info tại đây');}, //Gắn trang info
                    child: Container(
                        width: MediaQuery.of(context).size.width * (1 / 5),
                        height: MediaQuery.of(context).size.width * (1 / 5),
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          "https://ps.w.org/user-avatar-reloaded/assets/icon-256x256.png?rev=2540745",
                          fit: BoxFit.fill,
                        )
                      // child: avatar == 'null'
                      //     ? Image.network(
                      //   "https://ps.w.org/user-avatar-reloaded/assets/icon-256x256.png?rev=2540745",
                      //   fit: BoxFit.fill,
                      // )
                      //     : Image.network(
                      //   avatar,
                      //   fit: BoxFit.fill,
                      // ),
                    ),
                  ),
                ),
              ),
              Visibility(
                //visible: login == true,
                child: Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * (1 / 64)),
                  child: Container(
                    child: Text('Nguyễn Khải',
                      //'${utf8.decode(username.codeUnits)}',
                      style: GoogleFonts.getFont(
                        'Montserrat',
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
              Visibility(
                //visible: login == true,
                child: Container(
                  child: Text('email@gmail.com',
                    //'${utf8.decode(email.codeUnits)}',
                    style: GoogleFonts.getFont(
                      'Montserrat',
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              // Visibility(
              //     //visible: login == false,
              //     child: SizedBox(
              //       height: MediaQuery.of(context).size.height * (1 / 8),
              //     )),
              // Padding(
              //   padding: EdgeInsets.only(
              //     left: MediaQuery.of(context).size.width * (1 / 32),
              //     top: MediaQuery.of(context).size.height * (1 / 32),
              //     bottom: MediaQuery.of(context).size.height * (1 / 64),
              //   ),
              //   child: Container(
              //     // width: MediaQuery.of(context).size.width,
              //     child: Align(
              //       alignment: AlignmentDirectional(-1.00, 0),
              //       child: Text(
              //         'Thông báo',
              //         style: GoogleFonts.getFont(
              //           'Montserrat',
              //           color: Theme.of(context).primaryColor,
              //           fontWeight: FontWeight.w500,
              //           fontSize: 13,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              // Container(
              //   width: MediaQuery.of(context).size.width * 0.95,
              //   // height: MediaQuery.of(context).size.height * (1/12),
              //   decoration: BoxDecoration(
              //     color: Color(0xFFD9D9D9),
              //     borderRadius: BorderRadius.circular(15),
              //   ),
              //   child: Row(
              //     mainAxisSize: MainAxisSize.max,
              //     children: [
              //       Padding(
              //         padding: EdgeInsets.symmetric(
              //             horizontal: MediaQuery.of(context).size.width * 0.05,
              //             vertical: MediaQuery.of(context).size.height * 0.03),
              //         child: Align(
              //           alignment: AlignmentDirectional(-1.00, 0.00),
              //           child: Text(
              //             'Bật thông báo',
              //             style: GoogleFonts.getFont(
              //               'Montserrat',
              //               color: Colors.black,
              //               fontWeight: FontWeight.w600,
              //               fontSize: 15,
              //             ),
              //           ),
              //         ),
              //       ),
              //       Expanded(
              //         child: Align(
              //           alignment: AlignmentDirectional(1.00, 0.00),
              //           child: Padding(
              //             padding: EdgeInsets.symmetric(
              //               horizontal:
              //                   MediaQuery.of(context).size.width * 0.05,
              //               vertical:
              //                   MediaQuery.of(context).size.height * 0.005,
              //             ),
              //             child: CupertinoSwitch(
              //               value: _nofication,
              //               onChanged: (newValue) {
              //                 setState(() => _nofication = newValue!);
              //               },
              //               activeColor: Color(0xFF7D1F1F),
              //               trackColor: Color.fromRGBO(102, 102, 102, 100),
              //             ),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),

              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * (1 / 25)),
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Lịch sử thay đổi'),
                          content: HeightChartWidget(),
                        );
                      },
                    );
                    /*setState(() {
                      showChart = true;
                    });
                    if (showChart == true)
                      FatChartWidget();
                    else
                      SizedBox();*/
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) {
                    //   return Contact();
                    // }));
                  },

                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.95,
                    // height: MediaQuery.of(context).size.height * 0.08,
                    decoration: BoxDecoration(
                      color: Color(0xFFD9D9D9),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.05,
                          vertical: MediaQuery.of(context).size.height * 0.03),
                      child: Align(
                        alignment: AlignmentDirectional(-1.00, 0.00),
                        child: Text(
                          'Chiều cao                                       170 cm',
                          style: GoogleFonts.getFont(
                            'Montserrat',
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * (1 / 25)),
                child: InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Lịch sử thay đổi'),
                          content: WeightChartWidget(),
                        );
                      },
                      );
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) {
                    //   return CustomTable();
                    // }));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.95,
                    // height: MediaQuery.of(context).size.height * 0.08,
                    decoration: BoxDecoration(
                      color: Color(0xFFD9D9D9),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.05,
                          vertical: MediaQuery.of(context).size.height * 0.03),
                      child: Align(
                        alignment: AlignmentDirectional(-1.00, 0.00),
                        child: Text(
                          'Căn nặng                                          76 kg',
                          style: GoogleFonts.getFont(
                            'Montserrat',
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                        /*child: ListTile(
                          title: Text(
                            'Cân nặng',
                            style: GoogleFonts.getFont(
                            'Montserrat',
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                        subtitle: Text(
                            '70kg',
                            style: GoogleFonts.getFont(
                            'Montserrat',
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                        ),
                      ),
                    ),*/
                      ),
                    ),
                  ),
                ),
              ),

              Visibility(
                //visible: login == true,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * (1 / 25)),
                  child: InkWell(
                    onTap: () {
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) {
                      //   return Transcript();
                      // }));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.95,
                      // height: MediaQuery.of(context).size.height * 0.08,
                      decoration: BoxDecoration(
                        color: Color(0xFFD9D9D9),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                            MediaQuery.of(context).size.width * 0.05,
                            vertical:
                            MediaQuery.of(context).size.height * 0.03),
                        child: Align(
                          alignment: AlignmentDirectional(-1.00, 0.00),
                          child: Text(
                            'Ngày sinh                                 14/11/2003',
                            style: GoogleFonts.getFont(
                              'Montserrat',
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // Visibility(
              //     //visible: login == false,
              //     child: SizedBox(
              //       height: MediaQuery.of(context).size.height * (1 / 14),
              //     )
              // ),
              // InkWell(
              //   onTap: () {
              //     // Navigator.push(context, MaterialPageRoute(builder: (context) {
              //     //   return Esport();
              //     // }));
              //   },
              //   child: Container(
              //     width: MediaQuery.of(context).size.width * 0.95,
              //     // height: MediaQuery.of(context).size.height * 0.08,
              //     decoration: BoxDecoration(
              //       color: Color(0xFFD9D9D9),
              //       borderRadius: BorderRadius.circular(15),
              //     ),
              //     child: Padding(
              //       padding: EdgeInsets.symmetric(
              //           horizontal: MediaQuery.of(context).size.width * 0.05,
              //           vertical: MediaQuery.of(context).size.height * 0.03),
              //       child: Align(
              //         alignment: AlignmentDirectional(-1.00, 0.00),
              //         child: Text(
              //           'Esport',
              //           style: GoogleFonts.getFont(
              //             'Montserrat',
              //             color: Colors.black,
              //             fontWeight: FontWeight.w600,
              //             fontSize: 15,
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              Container(
                child: TextButton(
                  // onPressed: () {
                  //   logindata.clear();
                  //   logindata.setBool('login', false);
                  //   Navigator.pushReplacement(
                  //       context,
                  //       new MaterialPageRoute(
                  //           builder: (context) => MainPage(),
                  //           fullscreenDialog: true));
                  // },
                  style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all(Colors.transparent),
                  ),
                  onPressed: () {},
                  child: Text(
                    'Đăng xuất',
                    style: GoogleFonts.getFont(
                      'Montserrat',
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              // Visibility(
              //     //visible: login == false,
              //     child: SizedBox(
              //       height: MediaQuery.of(context).size.height * (1 / 14),
              //     )),
              // Tạo khoảng trống giữa hình ảnh và các nút, đẩy các nút xuống dưới cùng
              // Visibility(
              //   //visible: login == false,
              //   child: Container(
              //     width: MediaQuery.of(context).size.width * 0.95,
              //     child: TextButton(
              //       child: Text(
              //         'Đăng nhập',
              //         style: GoogleFonts.getFont(
              //           'Montserrat',
              //           color: Colors.white,
              //           fontWeight: FontWeight.w500,
              //           fontSize: 15,
              //         ),
              //       ),
              //       onPressed: () {
              //         // Navigator.push(
              //         //     context,
              //         //     MaterialPageRoute(
              //         //         builder: (context) => LoginPage(),
              //         //         fullscreenDialog: true));
              //       },
              //     ),
              //     decoration: BoxDecoration(
              //         color: Color(0xFF7D1F1F),
              //         borderRadius: BorderRadius.circular(20.0)),
              //   ),
              // ),

              // Visibility(
              //   //visible: login == false,
              //   child: Container(
              //     margin: EdgeInsets.only(
              //       top: MediaQuery.of(context).size.height * 0.02,
              //       bottom: MediaQuery.of(context).size.height * 0.07,
              //     ),
              //     width: MediaQuery.of(context).size.width * 0.95,
              //     height: 45,
              //     child: TextButton(
              //       style: ButtonStyle(
              //         backgroundColor:
              //         MaterialStateProperty.all<Color>(Colors.white),
              //         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              //           RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(20.0),
              //             // Điều chỉnh độ bo góc ở đây
              //             side: BorderSide(
              //               color: Color(0xFF7D1F1F), // Màu của viền
              //               width: 2.0, // Độ dày của viền
              //             ),
              //           ),
              //         ),
              //       ),
              //       child: Text(
              //         'Đăng nhập',
              //         style: GoogleFonts.getFont(
              //           'Montserrat',
              //           color: Color(0xFF7D1F1F),
              //           fontWeight: FontWeight.w500,
              //           fontSize: 15,
              //         ),
              //       ),
              //       onPressed: () {
              //         // Navigator.push(
              //         //     context,
              //         //     MaterialPageRoute(
              //         //         builder: (context) => RegisterPage()));
              //       },
              //     ),
              //    ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

}




