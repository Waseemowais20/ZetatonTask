import 'package:sqflite/sqflite.dart';
import 'package:zetaton_task/screens/home/models/pictures_model.dart';
import 'package:zetaton_task/utilites/database/database_helper.dart';

class FavoritesRepository {
  DatabaseHelper dbHelper = DatabaseHelper.instance;

  // control insert photo from in database
  Future<int> insertPhoto(Photo photo, String authToken) {
    return dbHelper.insertPhoto(photo, authToken);
  }

  // control get cached photo from database to provider
  Future<List<Photo>> getPhotosForUser(String authToken) async {
    return dbHelper.getPhotosForUser(authToken);
  }

  // control delete users selected photo from favorites and database
  Future<int> deletePhotoForUser(int photoId, String authToken) async {
    return dbHelper.deletePhotoForUser(photoId, authToken);
  }

}
