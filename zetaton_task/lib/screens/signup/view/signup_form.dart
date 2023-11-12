import 'package:flutter/material.dart';
import 'package:zetaton_task/constants/strings.dart';
import 'package:zetaton_task/screens/signup/provider/signup_provider.dart';
import 'package:zetaton_task/utilites/methods/shared_methods.dart';
import 'package:zetaton_task/utilites/widgets/shared_text.dart';
import 'package:zetaton_task/utilites/widgets/shared_widgets.dart';

// Signup form for request for new user
class SignupForm extends StatelessWidget {
  final TextEditingController firstName;
  final TextEditingController lastName;
  final TextEditingController email;
  final TextEditingController phone;
  final TextEditingController password;
  final TextEditingController rePassword;
  final SignUpProvider signUpProvider;

  const SignupForm(
      {Key? key,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.phone,
      required this.password,
      required this.rePassword,
      required this.signUpProvider})
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
            sharedText.text(AppStrings.register,
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
        Row(
          children: [
            Expanded(
              child: EditTextView(
                hint: 'First name',
                labelText: 'First name',
                controller: firstName,
                obscureText: false,
                paddingRight: 5,
                paddingLeft: 30,
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppStrings.enterFirstNameValidation.trim();
                  }
                },
              ),
            ),
            Expanded(
              child: EditTextView(
                hint: 'Last name',
                labelText: 'Last name',
                controller: lastName,
                paddingLeft: 5,
                paddingRight: 30,
                obscureText: false,
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppStrings.enterLastNameValidation.trim();
                  }
                },
              ),
            ),
          ],
        ),
        sharedMethods.emptySizeVertical(
            height: sharedMethods.height(15, context)),
        EditTextView(
          hint: 'Email',
          labelText: 'Email',
          controller: email,
          obscureText: false,
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
            height: sharedMethods.height(15, context)),
        EditTextView(
          hint: 'Phone number',
          labelText: 'Phone number',
          controller: phone,
          keyboardType: TextInputType.number,
          obscureText: false,
          validator: (value) {
            if (value!.isEmpty) {
              return AppStrings.enterPhoneValidation.trim();
            }
          },
        ),
        sharedMethods.emptySizeVertical(
            height: sharedMethods.height(15, context)),
        EditTextView(
          hint: 'Password',
          labelText: 'Password',
          controller: password,
          obscureText: signUpProvider.obscurePassword,
          validator: (value) {
            if (value!.isEmpty) {
              return AppStrings.enterPasswordValidation.trim();
            } else if (value.length < 6) {
              return AppStrings.passwordLengthError.trim();
            }
          },
          suffix: GestureDetector(
            onTap: () {
              signUpProvider.setShowPassword(!signUpProvider.obscurePassword);
            },
            child: Icon(!signUpProvider.obscurePassword
                ? Icons.visibility
                : Icons.visibility_off),
          ),
        ),
        sharedMethods.emptySizeVertical(
            height: sharedMethods.height(15, context)),
        EditTextView(
          hint: 'Re-password',
          labelText: 'Re-password',
          controller: rePassword,
          obscureText: signUpProvider.obscureRePassword,
          validator: (value) {
            if (value!.isEmpty) {
              return AppStrings.enterRePasswordValidation.trim();
            }
          },
          textInputAction: TextInputAction.done,
          suffix: GestureDetector(
            onTap: () {
              signUpProvider
                  .setShowRePassword(!signUpProvider.obscureRePassword);
            },
            child: Icon(!signUpProvider.obscureRePassword
                ? Icons.visibility
                : Icons.visibility_off),
          ),
        ),
        sharedMethods.emptySizeVertical(
            height: sharedMethods.height(30, context)),
      ],
    );
  }
}
