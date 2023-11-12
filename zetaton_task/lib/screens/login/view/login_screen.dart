import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zetaton_task/constants/colors.dart';
import 'package:zetaton_task/constants/strings.dart';
import 'package:zetaton_task/screens/favorites/provider/favorites_provider.dart';
import 'package:zetaton_task/screens/home/provider/download_image.dart';
import 'package:zetaton_task/screens/home/provider/home_provider.dart';
import 'package:zetaton_task/screens/home/provider/logout_provider.dart';
import 'package:zetaton_task/screens/home/view/navigation_bar.dart';
import 'package:zetaton_task/screens/login/provider/login_provider.dart';
import 'package:zetaton_task/screens/login/view/login_form.dart';
import 'package:zetaton_task/screens/login/view/login_header.dart';
import 'package:zetaton_task/screens/signup/provider/signup_provider.dart';
import 'package:zetaton_task/screens/signup/view/signup_screen.dart';
import 'package:zetaton_task/utilites/widgets/custom_toast.dart';
import 'package:zetaton_task/utilites/methods/shared_methods.dart';
import 'package:zetaton_task/utilites/widgets/shared_widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController();

  final password = TextEditingController();

  // formKey allows me to make validation on TextFormFileds like email and password
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              RegisterHeader(
                imagePath: 'assets/images/login.jpeg',
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
              ),
              LoginForm(
                email: email,
                password: password,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: sharedMethods.width(30, context)),
                child: Row(
                  children: [
                    Consumer<LoginProvider>(
                      builder: (context, loginProvider, child) {
                        return !loginProvider.signInLoading
                            ? Expanded(
                                flex: 5,
                                child: AppCommonButton(
                                    title: AppStrings.login,
                                    height: sharedMethods.height(40, context),
                                    width: sharedMethods.width(280, context),
                                    onTap: () async {
                                      if (_formKey.currentState!.validate()) {
                                        String? value = await loginProvider
                                            .signInWithEmailAndPassword(
                                                email.text.trim(),
                                                password.text);
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
                                                        DownloadImage>(
                                                    create: (context) =>
                                                        DownloadImage()),
                                                ChangeNotifierProvider<
                                                        FavoritesProvider>(
                                                    create: (context) =>
                                                        FavoritesProvider()),
                                              ],
                                              child: AppNavigationBar(),
                                            );
                                          }));

                                          CustomToast.show(
                                              context, 'Login Successful',
                                              color: AppColors.successfulColor);
                                        } else if (value == 'No Internet' &&
                                            mounted) {
                                          CustomToast.show(
                                              context, AppStrings.noInternet,
                                              color: AppColors.invalidColor);
                                        } else {
                                          CustomToast.show(context, '${value}',
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
                      },
                    ),
                    sharedMethods.emptySizeHorizontal(
                        width: sharedMethods.width(10, context)),
                    Expanded(
                      flex: 5,
                      child: AppCommonButton(
                          title: AppStrings.signup,
                          backGroundColor: AppColors.signupColor,
                          height: sharedMethods.height(40, context),
                          width: sharedMethods.width(280, context),
                          onTap: () async {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return MultiProvider(
                                providers: [
                                  ChangeNotifierProvider<LogoutProvider>(
                                      create: (context) => LogoutProvider()),
                                  ChangeNotifierProvider<SignUpProvider>(
                                      create: (context) => SignUpProvider()),
                                ],
                                child: SignUpScreen(),
                              );
                            }));
                          }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
