import 'package:flutter/material.dart';
import 'package:zetaton_task/constants/colors.dart';
import 'package:zetaton_task/constants/strings.dart';
import 'package:zetaton_task/screens/home/provider/logout_provider.dart';
import 'package:zetaton_task/screens/login/view/login_screen.dart';
import 'package:zetaton_task/utilites/methods/navigation_service.dart';
import 'package:zetaton_task/utilites/methods/shared_methods.dart';
import 'package:zetaton_task/utilites/widgets/shared_text.dart';
import 'package:zetaton_task/utilites/widgets/shared_widgets.dart';

class LogoutBottomSheet {
  // Logout bottom sheet dialog
  Future<void> commonBottomSheet(context, LogoutProvider logoutProvider) {
    return showModalBottomSheet<void>(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: sharedMethods.height(150, context),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(sharedMethods.width(45, context)),
                topLeft: Radius.circular(sharedMethods.width(45, context)),
              )),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                sharedText.text(AppStrings.logout,
                    fontWeight: FontWeight.w700,
                    color: AppColors.blackColor,
                    size: sharedMethods.height(20, context)),
                sharedMethods.emptySizeVertical(
                    height: sharedMethods.height(10, context)),
                sharedText.text(
                  AppStrings.areYouSureYouWantToLogOut,
                  fontWeight: FontWeight.w700,
                  color: AppColors.blackColor,
                ),
                sharedMethods.emptySizeVertical(
                    height: sharedMethods.height(10, context)),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: sharedMethods.height(10, context),
                    horizontal: sharedMethods.height(20, context),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: AppCommonButton(
                            height: sharedMethods.height(40, context),
                            title: AppStrings.cancel,
                            onTap: () {
                              navigationService.back(context);
                            }),
                      ),
                      sharedMethods.emptySizeHorizontal(
                          width: sharedMethods.width(20, context)),
                      Expanded(
                        child: AppCommonButton(
                            height: sharedMethods.height(40, context),
                            title: AppStrings.yesRemove,
                            onTap: () async {
                              String? result =
                                  await logoutProvider.logOut(context);
                              if (result == 'LogOut') {
                                if (context.mounted) {
                                  navigationService.navigator(
                                      context, const LoginPage());
                                }
                              } else {
                                print('Logout error');
                              }
                            }),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

LogoutBottomSheet logoutBottomSheet = LogoutBottomSheet();
