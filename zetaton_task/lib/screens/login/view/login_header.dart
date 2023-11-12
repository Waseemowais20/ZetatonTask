import 'package:flutter/material.dart';
import 'package:zetaton_task/utilites/methods/shared_methods.dart';

class RegisterHeader extends StatelessWidget {
  final String imagePath;
  final double height;
  final double width;

  const RegisterHeader(
      {Key? key,
      required this.imagePath,
      required this.height,
      required this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(sharedMethods.height(40, context)),
      child: SizedBox(
        height: height,
        width: width,
        child: Image.asset(
          imagePath,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
