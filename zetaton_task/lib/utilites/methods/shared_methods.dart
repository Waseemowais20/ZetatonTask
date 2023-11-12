import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SharedMethods {
  static GlobalKey<NavigatorState> materialKey = GlobalKey<NavigatorState>();

  // shared height
  double height(double a, BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double scalingFactor;

    if (screenHeight >= 1024) {
      // For iPad or larger screens in portrait
      scalingFactor = 900;
    } else {
      // For iPhone or smaller screens
      scalingFactor = 737;
    }

    return screenHeight / (scalingFactor / a);
  }

  //Shared Width
  double width(double a, BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double scalingFactor;

    if (screenWidth >= 768) {
      // For iPad or larger screens in portrait
      scalingFactor = 768;
    } else {
      // For iPhone or smaller screens
      scalingFactor = 392; // You can adjust this value as needed
    }

    return screenWidth / (scalingFactor / a);
  }

  // Empty size vertically
  Widget emptySizeVertical({double? height}) {
    return SizedBox(
      height: height,
    );
  }

  // Empty size horizontally
  Widget emptySizeHorizontal({double? width}) {
    return SizedBox(
      width: width,
    );
  }

  // shared launch Url function for website links
  Future<void> launchUrlLink(String urlLink) async {
    String url = urlLink;
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }
}

SharedMethods sharedMethods = SharedMethods();
