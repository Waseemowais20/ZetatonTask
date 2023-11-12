import 'package:zetaton_task/screens/home/models/pictures_model.dart';
import 'package:zetaton_task/screens/home/repository/pictures_network.dart';

class HomeRepository {

  // Get pictures from api network
  Future<PicturesModel> getAllPictures(String userInput) async {
    return await picturesNetwork.getAllPictures(userInput);
  }
}

HomeRepository homeRepository = HomeRepository();
