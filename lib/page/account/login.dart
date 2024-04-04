
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthylife/page/account/register.dart';
import 'package:healthylife/page/account/splashscreen.dart';
import 'package:healthylife/page/add_info/addinfo.dart';
import 'package:healthylife/page/auth.dart';
import 'package:healthylife/util/color_theme.dart';

class LoginPage extends StatefulWidget{
  const LoginPage ({super.key});

  @override
  State<LoginPage> createState() => _LoginState();
}

class _LoginState extends State<LoginPage>{
  bool _obscureText = true;
  bool _isInputEmpty = true;
  bool isLogin = true;
  String? errorMessage = '';

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  Future<void> signInWithEmailAndPassword() async{
    try{
      await Auth().signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
      );
    } on FirebaseAuthException catch(e){
      setState(() {
        errorMessage = e.message;
      });
    }
  }
  void initState(){
    super.initState();
    _passwordController.addListener(_checkInput);
  }

  // hàm kiểm tra TextFormField đã nhập hay chưa nhập
  void _checkInput(){
    setState(() {
      _isInputEmpty = _passwordController.text.isEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final screenWidth = MediaQuery.of(context).size.width;
    // final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              child: Align(
                alignment: Alignment.topCenter,
                child: Image.asset('assets/images/Vector2.png',
                  width: MediaQuery.of(context).size.width,
                  //height: MediaQuery.of(context).size.height,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const Positioned(
              top: 150,
              left: 0,
              right: 0,
              child: Center(
                child: Text("HEALTHY LIFE",
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.white,
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
                  //Navigator.push(context, MaterialPageRoute(builder: (context) => SplashScreenPage()));
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  //padding: const EdgeInsets.all(1),
                ),
                child: Icon(Icons.arrow_back_rounded,
                  size: 42,
                  color: ColorTheme.backgroundColor,
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
                  children: [
                    Container(
                      child: Center(
                        child: Text('Đăng nhập'.toUpperCase(),
                          style: TextStyle(
                              color: ColorTheme.backgroundColor,
                              fontSize: 32,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),

                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text('Email',
                      style: TextStyle(
                          color: Colors.grey
                      ),
                    ),
                    const SizedBox(height: 10,),
                    TextFormField(
                      decoration: const InputDecoration(
                          filled: true,
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
                          color: Colors.grey
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                          filled: true,
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          suffixIcon: _isInputEmpty
                              ? null
                              : IconButton(
                            onPressed: (){
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                            icon: Icon(
                              _obscureText ? Icons.visibility_off : Icons.visibility,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 15)
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          child: Text('Quên mật khẩu?',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              decorationThickness: 2.0,
                              color: ColorTheme.backgroundColor,
                              decorationColor: ColorTheme.backgroundColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(15),
                          backgroundColor: ColorTheme.backgroundColor,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => AddInfo()));
                        },
                        child: Text('Đăng nhập'.toUpperCase(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16,),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 15),
                            height: 2,
                            color: Colors.grey,
                          ),
                        ),
                        const Text('Hoặc',
                          style: TextStyle(color: Colors.grey),
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 15),
                            height: 2,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16,),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()));
                        },
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(const EdgeInsets.all(16)),
                          side: MaterialStateProperty.all(BorderSide(width: 2,color: ColorTheme.backgroundColor)),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        child: Text('Đăng ký'.toUpperCase(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: ColorTheme.backgroundColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }
}

