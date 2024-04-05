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
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * (1 / 16),
                ),
                child: InkWell(
                  onTap: () {
                    print('Gắn trang info tại đây');
                  }, //Gắn trang info
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
                      )),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * (1 / 64)),
                child: Container(
                  child: Text(
                    'Nguyễn Khải',
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
              Container(
                child: Text(
                  'email@gmail.com',
                  style: GoogleFonts.getFont(
                    'Montserrat',
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ),

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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Chiều cao',
                            style: GoogleFonts.getFont(
                              'Montserrat',
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            '170 cm',
                            style: GoogleFonts.getFont(
                              'Montserrat',
                              color: Colors.grey[700],
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Cân nặng',
                            style: GoogleFonts.getFont(
                              'Montserrat',
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            '76 kg',
                            style: GoogleFonts.getFont(
                              'Montserrat',
                              color: Colors.grey[700],
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              Padding(
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Ngày sinh',
                            style: GoogleFonts.getFont(
                              'Montserrat',
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            '14/11/2003',
                            style: GoogleFonts.getFont(
                              'Montserrat',
                              color: Colors.grey[700],
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              Container(
                child: TextButton(
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
            ],
          ),
        ),
      ),
    );
  }
}
