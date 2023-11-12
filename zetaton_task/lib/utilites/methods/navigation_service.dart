import 'package:flutter/material.dart';

class NavigationService {
  // Navigation without return back
  navigator(BuildContext context, Widget widget) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => widget), (route) => false);
  }

  // Navigation with return back
  navigatorWithBack(BuildContext context, Widget widget) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => widget));
  }

  // Back to previous context
  back(BuildContext context) {
    Navigator.pop(context);
  }
}

NavigationService navigationService = NavigationService();