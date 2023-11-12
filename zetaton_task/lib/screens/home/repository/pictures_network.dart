import 'package:zetaton_task/constants/constants.dart';
import 'package:zetaton_task/screens/home/models/pictures_model.dart';
import 'package:http/http.dart' as http;

class PicturesNetwork {
  // get all pictures from server side
  Future<PicturesModel> getAllPictures(String userInput) async {

    // default
    if (userInput.isEmpty) {
      userInput = 'Nature';
    }

    String url =
        '${Constants.baseUrl}/v1/search?query=$userInput&per_page=16&page=1';

    var response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            '563492ad6f91700001000001575c57ac3ec940cbba5f424b7f99475e',
        'Cookie':
            '__cf_bm=GIin24NTo7Duu_E2LDpkAPKfasdpc.zQRDMQd1DkZmU-1699545383-0-AVt+KhgsOYBJaJBDvGjnrF+5rx7E5XB/bAt5S4D9MkAtS0050WSA+RhcqP8voD1WEb452R+53FrdMEIkrKP44O4=; _cfuvid=YwSZCAZ32Ogg7pQ1.fh3QvNpXCPQvWE1d2ZfPH_ClTg-1699545393067-0-604800000'
      },
    );
    PicturesModel picturesModel = PicturesModel(
        page: 0, perPage: 0, photos: [], totalResults: 0, nextPage: '');

    if (response.statusCode == 200) {
      picturesModel = picturesModelFromJson(response.body);
    }
    return picturesModel;
  }
}

PicturesNetwork picturesNetwork = PicturesNetwork();
