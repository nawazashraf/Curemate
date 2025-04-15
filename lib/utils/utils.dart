import 'package:flutter/material.dart';

class Utils {
  static void showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.blueAccent,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
