import 'package:flutter/cupertino.dart';
import 'package:zetaton_task/screens/favorites/repository/favorities_repository.dart';
import 'package:zetaton_task/screens/home/models/pictures_model.dart';
import 'package:zetaton_task/utilites/database/database_helper.dart';
import 'package:zetaton_task/utilites/session_manager.dart';

class FavoritesProvider extends ChangeNotifier {
  List<Photo> favoriteList = [];

  final FavoritesRepository _favoritesRepository = FavoritesRepository();
  final SessionManager _sm = SessionManager();

  // Fetch fav list when the provider is created
  FavoritesProvider() {
    getCachedFavorites();
  }

  // Get cached favorites from database
  getCachedFavorites() async {
    String? authToken = await _sm.getAuthToken();
    try {
      await _favoritesRepository.getPhotosForUser(authToken!).then((value) {
        favoriteList = value;
        print(favoriteList.length);
      });
    } catch (e) {}
    notifyListeners();
  }
}
