import 'package:flutter/material.dart';
import 'package:zetaton_task/constants/colors.dart';
import 'package:zetaton_task/utilites/methods/shared_methods.dart';
import 'package:zetaton_task/utilites/widgets/shared_text.dart';

// Custom app bar used from AppBar screens application
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? leading;
  final Widget? action;
  final double? appBarHeight;

  const CustomAppBar(
      {Key? key,
      required this.title,
      required this.leading,
      required this.action,
      this.appBarHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading,
      backgroundColor: AppColors.whiteColor,
      elevation: 0,
      title: sharedText.appBarText(title!),
      centerTitle: true,
      actions: [action!],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBarHeight ?? kToolbarHeight);
}
