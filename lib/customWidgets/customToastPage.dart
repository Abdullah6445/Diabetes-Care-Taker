import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomToast {
  String message = "";
  CustomToast({required this.message}) {
    Fluttertoast.showToast(
      msg: message.toString(),
      gravity: ToastGravity.BOTTOM,
      fontSize: 15,
      backgroundColor: Color.fromARGB(255, 5, 65, 114),
      toastLength: Toast.LENGTH_LONG,
    );
  }
}
