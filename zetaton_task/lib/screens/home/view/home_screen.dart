import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zetaton_task/constants/colors.dart';
import 'package:zetaton_task/constants/strings.dart';
import 'package:zetaton_task/screens/home/provider/home_provider.dart';
import 'package:zetaton_task/screens/home/provider/logout_provider.dart';
import 'package:zetaton_task/screens/home/view/components/custom_search_dialog.dart';
import 'package:zetaton_task/screens/home/view/components/logout_bottom_sheet.dart';
import 'package:zetaton_task/screens/home/view/components/picture_list.dart';
import 'package:zetaton_task/utilites/widgets/appBar_custom.dart';
import 'package:zetaton_task/utilites/methods/shared_methods.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final authProvider = context.read<LogoutProvider>();
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CustomAppBar(
        appBarHeight: sharedMethods.height(40, context),
        title: AppStrings.search,
        leading: Container(),
        action: GestureDetector(
          onTap: () {
            logoutBottomSheet.commonBottomSheet(context, authProvider);
          },
          child: SizedBox(
            width: sharedMethods.width(50, context),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.logout_outlined,
                  color: AppColors.blackColor,
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Consumer<HomeProvider>(
          builder: (context, homeProvider, child) {
            return SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  sharedMethods.emptySizeVertical(
                      height: sharedMethods.height(20, context)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomSearchDialog(),
                    ],
                  ),
                  homeProvider.loadingPic
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height / 1.4,
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(child: CircularProgressIndicator()),
                            ],
                          ),
                        )
                      : PicturesList(
                          photos: homeProvider.allPictures,
                          type: 'server side',
                        ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
