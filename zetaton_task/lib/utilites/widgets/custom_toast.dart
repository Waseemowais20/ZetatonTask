import 'package:flutter/material.dart';
import 'package:zetaton_task/utilites/methods/shared_methods.dart';
import 'package:zetaton_task/utilites/widgets/shared_text.dart';

class CustomToast {
  static bool isVisible = false;

  // Custom toast bar
  static void show(BuildContext context, String msg, {Color? color}) {
    double snackWidth = 300;
    if (msg.length < 32) {
      snackWidth = msg.length.toDouble() * 10;
    }
    if (msg.length < 10) {
      snackWidth = msg.length.toDouble() * 22;
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Center(
          child: sharedText.text('$msg',
              color: Colors.white, size: sharedMethods.height(12, context))),
      behavior: SnackBarBehavior.floating,
      backgroundColor: color ?? Colors.black.withOpacity(0.8),
      duration: const Duration(milliseconds: 2500),
      width: snackWidth,
      elevation: 0,
      padding: EdgeInsets.only(
          left: sharedMethods.width(10, context),
          right: sharedMethods.height(10, context),
          top: sharedMethods.height(5, context),
          bottom: sharedMethods.height(5, context)),
      // width: 250,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ));
  }
}
