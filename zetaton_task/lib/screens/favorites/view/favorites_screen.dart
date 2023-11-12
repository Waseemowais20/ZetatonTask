import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zetaton_task/screens/favorites/provider/favorites_provider.dart';
import 'package:zetaton_task/screens/home/view/components/picture_list.dart';
import 'package:zetaton_task/utilites/widgets/shared_text.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<FavoritesProvider>(
      builder: (context, favProvider, child) {
        return SafeArea(
          child: favProvider.favoriteList.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        sharedText.text('Favorites photos is empty'),
                      ],
                    ),
                  ],
                )
              : PicturesList(
                  photos: favProvider.favoriteList,
                  type: 'local',
                ),
        );
      },
    );
  }
}
