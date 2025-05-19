import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class ToastManager {
  static final ToastManager _instance = ToastManager._internal();

  factory ToastManager() {
    return _instance;
  }

  ToastManager._internal();

  static showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 14.0,
    );
  }

  static showErrorToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      backgroundColor: Colors.redAccent,
      textColor: Colors.white,
      fontSize: 14.0,
    );
  }
}
