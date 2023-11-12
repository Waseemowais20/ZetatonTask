import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zetaton_task/screens/home/provider/download_image.dart';
import 'package:zetaton_task/screens/home/models/pictures_model.dart';
import 'package:zetaton_task/screens/home/view/components/pictures_details_screen.dart';
import 'package:zetaton_task/screens/home/view/components/pictures_widget.dart';
import 'package:zetaton_task/utilites/methods/navigation_service.dart';
import 'package:zetaton_task/utilites/methods/shared_methods.dart';

class PicturesList extends StatefulWidget {
  final List<Photo>? photos;
  final String type;

  const PicturesList({Key? key, required this.photos, required this.type})
      : super(key: key);

  @override
  State<PicturesList> createState() => _PicturesListState();
}

class _PicturesListState extends State<PicturesList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: GridView.builder(
        itemCount: widget.photos!.length,
        shrinkWrap: false,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.only(
            top: sharedMethods.height(10, context),
            left: sharedMethods.width(20, context),
            bottom:
                sharedMethods.height(widget.type == 'local' ? 0 : 250, context),
            right: sharedMethods.width(20, context)),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: sharedMethods.height(10, context),
            crossAxisSpacing: sharedMethods.width(10, context)),
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () {
                navigationService.navigatorWithBack(
                    context,
                    MultiProvider(
                        providers: [
                          ChangeNotifierProvider<DownloadImage>(
                            create: (context) => DownloadImage(),
                          )
                        ],
                        child: PicturesDetailsScreen(
                          photo: widget.photos![index],
                          type: widget.type,
                        )));
              },
              child: PictureWidget(
                photo: widget.photos![index],
                type: widget.type,
              ));
        },
      ),
    );
  }
}
