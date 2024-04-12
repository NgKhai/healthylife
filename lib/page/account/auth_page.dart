import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthylife/page/account/login.dart';
import 'package:healthylife/page/account/register.dart';
import 'package:healthylife/page/add_info/addinfo.dart';


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
              return AddInfo();
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