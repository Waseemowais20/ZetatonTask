import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zetaton_task/constants/colors.dart';
import 'package:zetaton_task/screens/home/provider/home_provider.dart';
import 'package:zetaton_task/utilites/methods/shared_methods.dart';

class CustomSearchDialog extends StatefulWidget {
  const CustomSearchDialog({
    Key? key,
  }) : super(key: key);

  @override
  _CustomSearchDialogState createState() => _CustomSearchDialogState();
}

class _CustomSearchDialogState extends State<CustomSearchDialog> {
  Timer? _checkTypingTimer;


  final TextEditingController _searchController = SearchController();

  // To check user key up from keyboard for search api optimization
  _startTimer(String value, BuildContext context, HomeProvider homeProvider) {
    _checkTypingTimer =
        Timer(Duration(milliseconds: value.length > 3 ? 300 : 100), () {
      homeProvider.getAllPictures(value);
      setState(() {});
    });
  }

  // Reset timer when writing another letter
  _resetTimer(String value, BuildContext context, HomeProvider homeProvider) {
    _checkTypingTimer?.cancel();
    _startTimer(value, context, homeProvider);
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.3,
              height: sharedMethods.height(45, context),
              child: TextField(
                controller: _searchController,
                style: TextStyle(
                    fontFamily: 'Varela Round',
                    fontSize: sharedMethods.width(13, context)),
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  _resetTimer(value, context, homeProvider);
                },
                autocorrect: true,
                decoration: InputDecoration(
                  hintText: 'Search your pictures',
                  hintStyle: TextStyle(
                      fontFamily: 'Varela Round',
                      fontSize: sharedMethods.height(12, context),
                      color: Colors.grey),
                  border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppColors.textFormFieldBorder),
                    borderRadius: BorderRadius.circular(
                        sharedMethods.height(16, context)),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          sharedMethods.height(16, context)),
                      borderSide: BorderSide(
                          style: BorderStyle.solid,
                          width: 1,
                          color: AppColors.textFormFieldBorder)),
                  suffixIcon: IconButton(
                    onPressed: () {
                      _searchController.clear();
                      _resetTimer('', context, homeProvider);
                    },
                    icon: Icon(
                      Icons.clear,
                      size: sharedMethods.height(15, context),
                    ),
                  ),
                ),
              ),
            ),
            sharedMethods.emptySizeHorizontal(
                width: sharedMethods.width(10, context)),
            Container(
              height: sharedMethods.height(45, context),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.blackColor.withOpacity(0.5)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.search,
                  color: AppColors.whiteColor,
                ),
              ),
            )
          ],
        ),
        sharedMethods.emptySizeVertical(
            height: sharedMethods.height(8, context))
      ],
    );
  }
}
