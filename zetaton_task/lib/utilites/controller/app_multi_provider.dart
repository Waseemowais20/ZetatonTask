import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zetaton_task/screens/favorites/provider/favorites_provider.dart';
import 'package:zetaton_task/screens/home/provider/download_image.dart';
import 'package:zetaton_task/screens/home/provider/home_provider.dart';
import 'package:zetaton_task/screens/home/provider/logout_provider.dart';
import 'package:zetaton_task/screens/login/provider/login_provider.dart';
import 'package:zetaton_task/screens/signup/provider/signup_provider.dart';

// All Providers used inside the app
class AppMultiProvider extends StatelessWidget {
  final Widget child;

  const AppMultiProvider({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LogoutProvider>(
          create: (context) => LogoutProvider(),
        ),
        ChangeNotifierProvider<SignUpProvider>(
          create: (context) => SignUpProvider(),
        ),
        ChangeNotifierProvider<LoginProvider>(
          create: (context) => LoginProvider(),
        ),
        ChangeNotifierProvider<HomeProvider>(
          create: (context) => HomeProvider(),
        ),
        ChangeNotifierProvider<DownloadImage>(
          create: (context) => DownloadImage(),
        ),
        ChangeNotifierProvider<FavoritesProvider>(
          create: (context) => FavoritesProvider(),
        )
      ],
      child: child,
    );
  }
}
