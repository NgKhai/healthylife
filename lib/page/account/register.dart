
import 'package:flutter/material.dart';
import 'package:healthylife/page/account/splashscreen.dart';

class RegisterPage extends StatefulWidget{
  const RegisterPage ({super.key});

  @override
  State<RegisterPage> createState() => _RegisterState();
}

class _RegisterState extends State<RegisterPage>{
  String? errorMessage = '';
  bool isLogin = true;
  bool _obscureText = true;
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDE5044),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              child: Align(
                alignment: Alignment.topCenter,
                child: Image.asset('assets/images/Vector3.png',
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 150,
              right: 0,
              left: 0,
              child: Center(
                child: Text('Healthy life'.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 40,
                    color: Color(0xFFDE5044),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 40,
              left: -10,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    backgroundColor: const Color(0xFFDE5044)
                  //padding: const EdgeInsets.all(1),
                ),
                child: const Icon(Icons.arrow_back_rounded,
                  size: 42,
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
                top: 300,
                left: 30,
                right: 30,
                child: Center(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:[
                          Container(
                            child: Center(
                              child: Text('Đăng ký'.toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          const Text('Email',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                                filled: true,
                                //fillColor: ,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none
                                ),
                                contentPadding: EdgeInsets.symmetric(horizontal: 15)
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          const Text('Mật khẩu',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            obscureText: _obscureText,
                            decoration: const InputDecoration(
                                filled: true,
                                //fillColor: ,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none
                                ),
                                contentPadding: EdgeInsets.symmetric(horizontal: 15)
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          const Text('Nhập lại mật khẩu',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            obscureText: _obscureText,
                            decoration: const InputDecoration(
                                filled: true,
                                //fillColor: ,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none
                                ),
                                contentPadding: EdgeInsets.symmetric(horizontal: 15)
                            ),
                          ),
                          //const SizedBox(height: 16,),
                          Row(
                            //crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: CheckboxListTile(
                                  controlAffinity: ListTileControlAffinity.leading,
                                  contentPadding: EdgeInsets.zero,
                                  activeColor: Colors.white,
                                  checkColor: Color(0xFFDE5044),
                                  tileColor: Colors.transparent,
                                  title: const Text('Hiển thị mật khẩu',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  value: !_obscureText,
                                  onChanged: (value){
                                    setState(() {
                                      _obscureText = !value!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all(const EdgeInsets.all(16)),
                                side: MaterialStateProperty.all(const BorderSide(width: 2,color: Color(0xFFDE5044))),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                              child: Text('Đăng ký'.toUpperCase(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Color(0xFFDE5044),
                                ),
                              ),
                            ),
                          ),
                        ]
                    )
                )
            ),
          ],
        ),
      ),
    );
  }

}