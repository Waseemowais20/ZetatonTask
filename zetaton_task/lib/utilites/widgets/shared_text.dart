import 'package:flutter/material.dart';

class SharedText{
  // shared text
  Widget text(
      String text, {
        VoidCallback? onTap,
        double size = 14,
        Color color = Colors.black,
        String font = 'm',
        FontWeight fontWeight = FontWeight.normal,
        double height = 1.5,
        TextAlign align = TextAlign.start,
        TextOverflow? overFlow,
        TextDirection? direction,
        int? maxLines,
      }) {
    return InkWell(
      onTap: onTap,
      child: Text(text,
          textAlign: align,
          maxLines: maxLines,
          style: TextStyle(
            color: color,
            fontSize: size,
            fontWeight: fontWeight,
            height: height,
            overflow: overFlow,
          )),
    );
  }

  // AppBars text
  Widget appBarText(
      String text, {
        VoidCallback? onTap,
        double size = 20,
        Color color = Colors.black,
        String font = 'm',
        FontWeight fontWeight = FontWeight.bold,
        double height = 1.5,
        TextAlign align = TextAlign.start,
        TextOverflow? overFlow,
        TextDirection? direction,
        int? maxLines,
      }) {
    return InkWell(
      onTap: onTap,
      child: Text(text,
          textAlign: align,
          maxLines: maxLines,
          style: TextStyle(
            color: color,
            fontSize: size,
            fontWeight: fontWeight,
            height: height,
            overflow: overFlow,
          )),
    );
  }

}

SharedText sharedText = SharedText();