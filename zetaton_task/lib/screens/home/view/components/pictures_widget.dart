import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zetaton_task/screens/favorites/provider/favorites_provider.dart';
import 'package:zetaton_task/screens/favorites/view/favorites_download.dart';
import 'package:zetaton_task/screens/home/models/pictures_model.dart';
import 'package:zetaton_task/utilites/session_manager.dart';

import 'package:zetaton_task/utilites/methods/shared_methods.dart';

class PictureWidget extends StatefulWidget {
  final Photo? photo;
  final String type;

  const PictureWidget({Key? key, required this.photo, required this.type})
      : super(key: key);

  @override
  State<PictureWidget> createState() => _PictureWidgetState();
}

class _PictureWidgetState extends State<PictureWidget> {
  SessionManager sm = SessionManager();

  @override
  Widget build(BuildContext context) {
    final favProvider = Provider.of<FavoritesProvider>(context, listen: false);

    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black26),
          borderRadius:
              BorderRadius.circular(sharedMethods.height(20, context))),
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.transparent,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(sharedMethods.height(20, context)),
                    topLeft: Radius.circular(sharedMethods.height(20, context)),
                ),
                child: Image.network(
                  widget.photo!.src.portrait,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: sharedMethods.width(30, context),
                  vertical: sharedMethods.height(9, context)),
              child: SizedBox(
                height: sharedMethods.height(20, context),
                child: FavoritesDownload(
                  type: widget.type,
                  photo: widget.photo!,
                  favProvider: favProvider,
                  detailsScreen: false,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
