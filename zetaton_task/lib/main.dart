import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:zetaton_task/screens/home/provider/logout_provider.dart';
import 'package:zetaton_task/screens/home/view/navigation_bar.dart';
import 'package:zetaton_task/screens/login/provider/login_provider.dart';
import 'package:zetaton_task/screens/login/view/login_screen.dart';
import 'package:zetaton_task/utilites/session_manager.dart';
import 'package:zetaton_task/utilites/methods/navigation_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _navigateToScreen();
  }

  Future<void> _navigateToScreen() async {
    _timer = Timer(Duration(milliseconds: 2500), () async {
      SessionManager sm = SessionManager();
      String? authToken = await sm.getAuthToken();

      final Widget screen = authToken == null
          ? LoginPage()
          : AppNavBarPage();
      if (context.mounted) {
        navigationService.navigator(context, screen);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Image.asset("assets/images/splash_screen.png"),
            )
          ],
        ),
      ),
    );
  }
}
