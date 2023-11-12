import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zetaton_task/constants/strings.dart';
import 'package:zetaton_task/screens/login/provider/login_provider.dart';
import 'package:zetaton_task/utilites/methods/shared_methods.dart';
import 'package:zetaton_task/utilites/widgets/shared_text.dart';
import 'package:zetaton_task/utilites/widgets/shared_widgets.dart';


class LoginForm extends StatelessWidget {
  final TextEditingController email;
  final TextEditingController password;

  const LoginForm({Key? key, required this.email, required this.password})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        sharedMethods.emptySizeVertical(
            height: sharedMethods.height(10, context)),
        Row(
          children: [
            sharedMethods.emptySizeHorizontal(
                width: sharedMethods.width(30, context)),
            sharedText.text(AppStrings.welcomeBack,
                fontWeight: FontWeight.bold,
                size: sharedMethods.height(20, context)),
          ],
        ),
        Row(
          children: [
            sharedMethods.emptySizeHorizontal(
                width: sharedMethods.width(32, context)),
            sharedText.text(AppStrings.loginText1,
                size: sharedMethods.height(10, context)),
          ],
        ),

        sharedMethods.emptySizeVertical(
            height: sharedMethods.height(20, context)),

        // Email textFormField
        EditTextView(
          hint: AppStrings.email,
          labelText: AppStrings.email,
          controller: email,
          obscureText: false,
          suffix: Icon(Icons.email),
          validator: (value) {
            if (value!.isEmpty) {
              return AppStrings.enterEmailValidation.trim();
            } else if (!RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                .hasMatch(email.text)) {
              return 'Example@address.com';
            }
          },
        ),

        sharedMethods.emptySizeVertical(
            height: sharedMethods.height(20, context)),

        // Password textFormField
        Consumer<LoginProvider>(builder: (context, loginProvider, child) {
          return EditTextView(
            hint: AppStrings.password,
            labelText: AppStrings.password,
            controller: password,
            obscureText: loginProvider.obscurePassword,
            validator: (value) {
              if (value!.isEmpty) {
                return AppStrings.enterPasswordValidation.trim();
              }
            },
            textInputAction: TextInputAction.done,
            suffix: GestureDetector(
              onTap: () {
                loginProvider.setShowPassword(!loginProvider.obscurePassword);
              },
              child: Icon(!loginProvider.obscurePassword
                  ? Icons.visibility
                  : Icons.visibility_off),
            ),
          );
        }),

        sharedMethods.emptySizeVertical(
            height: sharedMethods.height(40, context)),
      ],
    );
  }
}
