import 'dart:ui';

import 'package:flutter/material.dart';

class SnackBarErrorMess{
  static void show(BuildContext context, String mess, {Color backgroundColor = Colors.red}){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(mess),
          backgroundColor: backgroundColor,
      )
    );
  }
}