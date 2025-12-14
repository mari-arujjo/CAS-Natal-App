import 'package:flutter/material.dart';

class SnackBarUtils {
  static void showCustomSnackbar(BuildContext context,String text,Color backgroundColor,) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          text,
          style: TextStyle(
            color: backgroundColor.computeLuminance() > 0.5 ? Colors.black : Colors.white,
          ),
        ),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.fixed,
      ),
    );
  }
}