import 'package:flutter/material.dart';
import 'package:zetaton_task/constants/colors.dart';
import 'package:zetaton_task/utilites/methods/shared_methods.dart';
import 'package:zetaton_task/utilites/widgets/shared_text.dart';

// Shared textFormFields inside app
class EditTextView extends StatelessWidget {
  const EditTextView(
      {Key? key,
      required this.hint,
      required this.labelText,
      required this.controller,
      required this.obscureText,
      this.autoValidateMode,
      this.suffix,
      this.validator,
      this.paddingRight,
      this.paddingLeft,
      this.textInputAction,
      this.keyboardType})
      : super(key: key);
  final String hint;
  final String labelText;
  final bool obscureText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final Widget? suffix;
  final AutovalidateMode? autoValidateMode;
  final double? paddingRight;
  final double? paddingLeft;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          right: paddingRight ?? sharedMethods.width(30, context),
          left: paddingLeft ?? sharedMethods.width(30, context)),
      child: TextFormField(
        obscureText: obscureText,
        controller: controller,
        validator: validator,
        keyboardType: keyboardType ?? TextInputType.text,
        textInputAction: textInputAction ?? TextInputAction.next,
        autovalidateMode:
            autoValidateMode ?? AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(sharedMethods.height(10, context)),
            hintText: hint,
            labelText: labelText,
            labelStyle: TextStyle(
                color: Colors.black45,
                fontSize: sharedMethods.height(10, context)),
            hintStyle: TextStyle(
                color: Colors.black45,
                fontSize: sharedMethods.height(10, context)),
            suffixIcon: suffix,
            enabledBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(sharedMethods.width(15, context)),
                borderSide: BorderSide(
                    color: Colors.black,
                    width: sharedMethods.width(0.5, context))),
            border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(sharedMethods.width(15, context)),
                borderSide: BorderSide(
                    color: Colors.black,
                    width: sharedMethods.width(1, context)))),
      ),
    );
  }
}

// Shared Common button in the app
class AppCommonButton extends StatelessWidget {
  const AppCommonButton(
      {Key? key,
      required this.title,
      required this.onTap,
      this.height,
      this.width,
      this.fontSize,
      this.backGroundColor,
      this.loading})
      : super(key: key);
  final String title;
  final Function() onTap;
  final double? height;
  final double? width;
  final double? fontSize;
  final Color? backGroundColor;
  final bool? loading;

  @override
  Widget build(BuildContext context) {
    return (loading ?? false)
        ? const CircularProgressIndicator(
            backgroundColor: Colors.white,
          )
        : Container(
            width: width ?? sharedMethods.width(380, context),
            height: height ?? sharedMethods.height(50, context),
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(sharedMethods.height(100, context)),
              boxShadow: [
                BoxShadow(
                  color: Colors.white,
                  offset: Offset(4, 8),
                  blurRadius: 12,
                ),
              ],
            ),
            child: ElevatedButton(
                onPressed: onTap,
                style: ButtonStyle(
                    elevation: MaterialStateProperty.all(8),
                    backgroundColor: MaterialStateProperty.all(
                        backGroundColor ?? Colors.blue),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          sharedMethods.height(13, context)),
                    ))),
                child: sharedText.text(title, color: AppColors.whiteColor)),
          );
  }
}
