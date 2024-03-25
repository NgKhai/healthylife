
import 'package:flutter/material.dart';
import 'package:healthylife/page/account/login.dart';
import 'package:healthylife/page/account/register.dart';

class SplashScreenPage extends StatelessWidget{
  const SplashScreenPage({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Stack(
        children: [
          const Positioned(
            top: 150,
            left: 0,
            right: 0,
            child: Center(
              child: Text("HEALTHY LIFE",
                style: TextStyle(
                  fontSize: 40,
                  color: Color(0xFFDE5044),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset('assets/images/Vector.png',
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover
              ,
            ),
          ),

          Align(
            //alignment: Alignment.bottomRight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              //crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                SizedBox(
                  width: 300,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,  // màu nền của button
                      foregroundColor: const Color(0xFFDE5044),  // màu chữ của button
                      shape: RoundedRectangleBorder(  // border radius của button
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()));
                    },
                    child: Text('Đăng ký'.toUpperCase(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16,),
                SizedBox(
                  width: 300,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFFDE5044),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    child: Text('Đăng nhập'.toUpperCase(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: GestureDetector(
                    // onTap: () {
                    //   // Navigator.push(
                    //   //   context as BuildContext,
                    //   //   MaterialPageRoute(builder: (context)),
                    //   // );
                    // },
                    child: const Text('Đăng nhập không cần tài khoản',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.white,
                        decorationThickness: 2.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 80),
                //SizedBox(height: ,)
              ],
            ),
          ),

        ],
      ),
    );
  }
}


