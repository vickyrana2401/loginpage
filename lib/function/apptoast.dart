import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppToast {
  AppToast._(); // prevents object creation

  static void show(
      String message, {
        Toast toastLength = Toast.LENGTH_SHORT,
        ToastGravity gravity = ToastGravity.BOTTOM,
        Color backgroundColor = Colors.black87,
        Color textColor = Colors.white,
        double fontSize = 14,
      }) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: toastLength,
      gravity: gravity,
      timeInSecForIosWeb: 2,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: fontSize,
      webBgColor: "linear-gradient(to right, #000000, #000000)",
    );
  }
}
