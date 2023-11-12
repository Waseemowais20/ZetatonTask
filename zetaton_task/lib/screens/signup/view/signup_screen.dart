import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zetaton_task/constants/colors.dart';
import 'package:zetaton_task/constants/strings.dart';
import 'package:zetaton_task/screens/favorites/provider/favorites_provider.dart';
import 'package:zetaton_task/screens/home/provider/download_image.dart';
import 'package:zetaton_task/screens/home/provider/home_provider.dart';
import 'package:zetaton_task/screens/home/view/navigation_bar.dart';
import 'package:zetaton_task/screens/home/provider/logout_provider.dart';
import 'package:zetaton_task/screens/login/models/user_model.dart';
import 'package:zetaton_task/screens/login/view/login_header.dart';
import 'package:zetaton_task/screens/signup/provider/signup_provider.dart';
import 'package:zetaton_task/screens/signup/view/signup_form.dart';
import 'package:zetaton_task/utilites/methods/navigation_service.dart';
import 'package:zetaton_task/utilites/widgets/custom_toast.dart';
import 'package:zetaton_task/utilites/methods/shared_methods.dart';
import 'package:zetaton_task/utilites/widgets/shared_widgets.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController rePassword = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<LogoutProvider>(context, listen: false);
    return Scaffold(
        body: SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Consumer<SignUpProvider>(
            builder: (context, signUpProvider, child) {
              return Column(
                children: [
                  RegisterHeader(
                      imagePath: 'assets/images/signup.jpeg',
                      height: MediaQuery.of(context).size.height / 3,
                      width: MediaQuery.of(context).size.width),
                  SignupForm(
                    firstName: firstName,
                    lastName: lastName,
                    email: email,
                    phone: phone,
                    password: password,
                    rePassword: rePassword,
                    signUpProvider: signUpProvider,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: sharedMethods.width(30, context)),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              navigationService.back(context);
                            },
                            child: Container(
                              height: sharedMethods.height(40, context),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.signupColor,
                              ),
                              alignment: Alignment.center,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: sharedMethods.width(5, context)),
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  color: AppColors.whiteColor,
                                  size: sharedMethods.height(20, context),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Consumer<SignUpProvider>(
                            builder: (context, signupPro, child) {
                          return !signupPro.signInLoading
                              ? Expanded(
                                  flex: 5,
                                  child: AppCommonButton(
                                      title: 'Signup',
                                      height: sharedMethods.height(40, context),
                                      width: sharedMethods.width(280, context),
                                      onTap: () {
                                        if (_formKey.currentState!.validate()) {
                                          if (password.text ==
                                              rePassword.text) {
                                            UserModel userModel = UserModel(
                                              firstName: firstName.text.trim(),
                                              lastName: lastName.text.trim(),
                                              phoneNumber: phone.text.trim(),
                                              email: email.text.trim(),
                                            );
                                            signupPro
                                                .createAccountWithEmail(
                                                    email.text,
                                                    password.text,
                                                    userModel)
                                                .then((value) {
                                              if (value == "Success") {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                  return MultiProvider(
                                                    providers: [
                                                      ChangeNotifierProvider<
                                                              HomeProvider>(
                                                          create: (context) =>
                                                              HomeProvider()),
                                                      ChangeNotifierProvider<
                                                              FavoritesProvider>(
                                                          create: (context) =>
                                                              FavoritesProvider()),
                                                      ChangeNotifierProvider<
                                                              DownloadImage>(
                                                          create: (context) =>
                                                              DownloadImage()),
                                                    ],
                                                    child: AppNavigationBar(),
                                                  );
                                                }));

                                                CustomToast.show(context,
                                                    'User Created Successfully',
                                                    color: AppColors
                                                        .successfulColor);
                                              } else if (value ==
                                                  'No Internet') {
                                                CustomToast.show(context,
                                                    'No internet Connection',
                                                    color:
                                                        AppColors.invalidColor);
                                              } else {
                                                CustomToast.show(
                                                    context, '$value',
                                                    color:
                                                        AppColors.invalidColor);
                                              }
                                              return null;
                                            });
                                          } else {
                                            CustomToast.show(context,
                                                AppStrings.passwordMatchError,
                                                color: AppColors.invalidColor);
                                          }
                                        }
                                      }),
                                )
                              : const Expanded(
                              flex: 5,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircularProgressIndicator(),
                                ],
                              ));
                        })
                      ],
                    ),
                  ),
                  sharedMethods.emptySizeVertical(
                      height: sharedMethods.height(40, context))
                ],
              );
            },
          ),
        ),
      ),
    ));
  }
}
