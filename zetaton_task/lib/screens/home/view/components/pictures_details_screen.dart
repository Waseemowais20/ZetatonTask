import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zetaton_task/constants/colors.dart';
import 'package:zetaton_task/constants/strings.dart';
import 'package:zetaton_task/screens/favorites/provider/favorites_provider.dart';
import 'package:zetaton_task/screens/favorites/view/favorites_download.dart';
import 'package:zetaton_task/screens/home/models/pictures_model.dart';
import 'package:zetaton_task/screens/home/provider/download_image.dart';
import 'package:zetaton_task/utilites/widgets/appBar_custom.dart';
import 'package:zetaton_task/utilites/methods/navigation_service.dart';
import 'package:zetaton_task/utilites/methods/shared_methods.dart';
import 'package:zetaton_task/utilites/widgets/custom_toast.dart';
import 'package:zetaton_task/utilites/widgets/shared_text.dart';
import 'package:zetaton_task/utilites/widgets/shared_widgets.dart';

class PicturesDetailsScreen extends StatefulWidget {
  final Photo? photo;
  final String type;

  const PicturesDetailsScreen(
      {Key? key, required this.photo, required this.type})
      : super(key: key);

  @override
  State<PicturesDetailsScreen> createState() => _PicturesDetailsScreenState();
}

class _PicturesDetailsScreenState extends State<PicturesDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CustomAppBar(
        title: AppStrings.picDetails,
        leading: GestureDetector(
            onTap: () {
              navigationService.back(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: AppColors.blackColor,
            )),
        action: Container(),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: sharedMethods.width(10, context)),
            child: sharedText.text(widget.photo!.alt,
                fontWeight: FontWeight.bold,
                size: sharedMethods.height(15, context)),
          ),
          sharedMethods.emptySizeVertical(
              height: sharedMethods.height(20, context)),
          SizedBox(
            height: sharedMethods.height(250, context),
            width: MediaQuery.of(context).size.width,
            child: ClipRRect(
              borderRadius:
                  BorderRadius.circular(sharedMethods.height(20, context)),
              child: Image.network(
                widget.photo!.src.portrait,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: sharedMethods.height(10, context),
                left: sharedMethods.width(20, context)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.person_outline),
                    sharedMethods.emptySizeHorizontal(
                        width: sharedMethods.width(20, context)),
                    sharedText.text('${widget.photo!.photographer}'),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    sharedMethods.launchUrlLink(widget.photo!.photographerUrl);
                  },
                  child: Row(
                    children: [
                      Icon(Icons.account_circle),
                      sharedMethods.emptySizeHorizontal(
                          width: sharedMethods.width(20, context)),
                      sharedText.text('Check user profile here',
                          color: AppColors.urlColor),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.color_lens),
                    sharedMethods.emptySizeHorizontal(
                        width: sharedMethods.width(20, context)),
                    sharedText.text('${widget.photo!.avgColor}'),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.insert_drive_file_outlined),
                    sharedMethods.emptySizeHorizontal(
                        width: sharedMethods.width(20, context)),
                    sharedText.text('${widget.photo!.id}'),
                  ],
                ),
                sharedMethods.emptySizeVertical(
                    height: sharedMethods.height(20, context)),
                Consumer2<FavoritesProvider, DownloadImage>(
                  builder: (context, favProvider, downloadImage, child) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: sharedMethods.width(30, context),
                          vertical: sharedMethods.height(9, context)),
                      child: AppCommonButton(
                        height: sharedMethods.height(30, context),
                        onTap: () {
                          widget.photo?.downloading = true;
                          setState(() {});

                          downloadImage
                              .downloadImage(
                                  widget.photo!.src.portrait, "TestImages")
                              .then((value) {
                            if (value == true) {
                              CustomToast.show(context, AppStrings.downloaded,
                                  color: AppColors.successfulColor);
                            } else {
                              CustomToast.show(
                                  context, AppStrings.errorDownloading,
                                  color: AppColors.invalidColor);
                            }
                            widget.photo!.downloading = false;
                            setState(() {});
                          });
                        },
                        title: 'Download',
                      ),
                    );
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
