import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zetaton_task/constants/colors.dart';
import 'package:zetaton_task/constants/strings.dart';
import 'package:zetaton_task/screens/favorites/provider/favorites_provider.dart';
import 'package:zetaton_task/screens/favorites/repository/favorities_repository.dart';
import 'package:zetaton_task/screens/home/provider/download_image.dart';
import 'package:zetaton_task/screens/home/models/pictures_model.dart';
import 'package:zetaton_task/utilites/session_manager.dart';
import 'package:zetaton_task/utilites/widgets/custom_toast.dart';
import 'package:zetaton_task/utilites/methods/shared_methods.dart';

class FavoritesDownload extends StatefulWidget {
  final String type;
  final Photo photo;
  final FavoritesProvider favProvider;
  final bool detailsScreen;

  const FavoritesDownload(
      {Key? key,
      required this.type,
      required this.photo,
      required this.favProvider,
      required this.detailsScreen})
      : super(key: key);

  @override
  State<FavoritesDownload> createState() => _FavoritesDownloadState();
}

class _FavoritesDownloadState extends State<FavoritesDownload> {
  final SessionManager _sm = SessionManager();

  final FavoritesRepository _favRepo = FavoritesRepository();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Consumer<DownloadImage>(
          builder: (context, downloadImage, _) {
            return GestureDetector(
              onTap: () {
                widget.photo.downloading = true;

                downloadImage
                    .downloadImage(widget.photo.src.portrait, "TestImages")
                    .then((value) {
                  if (value == true) {
                    CustomToast.show(context, AppStrings.downloaded,
                        color: AppColors.successfulColor);
                  } else {
                    CustomToast.show(context, AppStrings.errorDownloading,
                        color: AppColors.invalidColor);
                  }
                  widget.photo.downloading = false;
                });
              },
              child: SizedBox(
                  width: sharedMethods.width(50, context),
                  height: sharedMethods.height(30, context),
                  child: widget.photo.downloading
                      ? SizedBox(
                          height: sharedMethods.height(30, context),
                          width: sharedMethods.width(30, context),
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                          ))
                      : Icon(Icons.download)),
            );
          },
        ),
        !widget.detailsScreen
            ? GestureDetector(
                onTap: () async {
                  String? authToken = await _sm.getAuthToken();
                  // Check if we are getting this pic locally delete it
                  if (widget.type == 'local') {
                    try {
                      await _favRepo.deletePhotoForUser(
                          widget.photo.id, authToken!);
                    } catch (e) {}
                    widget.favProvider.getCachedFavorites();
                  }
                  // if we are getting this photo from server side save it to favorites
                  else {
                    // Assuming you have the 'photo' instance available
                    Photo photo = widget.photo;

                    int result = 0;
                    try {
                      // Insert the photo into the database
                      result = await _favRepo.insertPhoto(photo, authToken!);
                    } catch (e) {
                      print(e);
                    }

                    if (result != 0) {
                      // Success: Photo inserted into the database
                      if (mounted) {
                        CustomToast.show(context, AppStrings.addedToFav,
                            color: AppColors.successfulColor);
                      }
                      widget.favProvider.getCachedFavorites();
                    } else {
                      // Failure: Unable to insert the photo into the database
                      if (mounted) {
                        CustomToast.show(context, AppStrings.errorAddingToFav,
                            color: AppColors.invalidColor);
                      }
                    }
                  }
                },
                child: SizedBox(
                    width: sharedMethods.width(50, context),
                    height: sharedMethods.height(30, context),
                    child: Icon(widget.type == 'local'
                        ? Icons.favorite
                        : Icons.favorite_border)),
              )
            : Container(),
      ],
    );
  }
}
