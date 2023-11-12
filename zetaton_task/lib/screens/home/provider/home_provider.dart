import 'package:flutter/cupertino.dart';
import 'package:zetaton_task/screens/home/models/pictures_model.dart';
import 'package:zetaton_task/screens/home/repository/home_repository.dart';

class HomeProvider extends ChangeNotifier {
  List<Photo> allPictures = [];

  // Fetch allPictures list when home provider is created
  HomeProvider() {
    getAllPictures('Nature');
  }

  bool loadingPic = false;

  // Loading pictures
  _setLoadingPic(bool newValue) {
    loadingPic = newValue;
    notifyListeners();
  }

  // get all pictures from server after calling it from http network
  Future<void> getAllPictures(String userInput) async {
    _setLoadingPic(true);
    try {
      await homeRepository.getAllPictures(userInput).then((value) {
        allPictures = value.photos;
        _setLoadingPic(false);
        notifyListeners();
      });
    } catch (e) {
      _setLoadingPic(false);
    }
  }
}
