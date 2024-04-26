import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthylife/model/UserHealthy.dart';
import 'package:healthylife/page/account/login.dart';
import 'package:healthylife/page/account/register.dart';
import 'package:healthylife/page/add_info/addinfo.dart';
import 'package:healthylife/widget/home/home_bottom_navigation.dart';


class AuthPage extends StatelessWidget{
  const AuthPage({Key? key}) : super(key:key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.active){
            User? user = snapshot.data;
            if(user !=null){
              return HomeBottomNavigation(userHealthy: UserHealthy('lCIdlGoR2V2HPOEOFkF9', 'nguyenkhai1470@gmail.com', 'test123456', 'Nguyễn Khải', 'https://static.vecteezy.com/system/resources/previews/011/459/666/original/people-avatar-icon-png.png', DateTime.now()));
            } else{
              return LoginPage();
            }
          }
          return const CircularProgressIndicator();
          //user login
          // if(snapshot.hasData && snapshot.hasData != null){
          //   return AddInfo();
          // }
          // // user not login
          // else{
          //   return LoginPage();
          // }
        }
      )
    );
  }

}