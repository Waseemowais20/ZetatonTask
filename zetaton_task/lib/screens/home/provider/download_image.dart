import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:zetaton_task/utilites/methods/permission_request.dart';


class DownloadImage with ChangeNotifier {
  // Download selected image on users device
  Future<bool> downloadImage(String url, String fileName) async {
    notifyListeners();

    bool success = false;

    try {
      // Check and request permission
      if (await checkPermission()) {
        if (Platform.isIOS) {
          var imageId = await ImageDownloader.downloadImage(url);
        } else {
          _downloadAndroid(url);
        }
        success = true;
      }
    } on PlatformException catch (error) {
      print(error);
    } finally {
      notifyListeners();
    }

    return success;
  }

  // Download images to files on android
  Future<void> _downloadAndroid(String url) async {
    var dateTime = DateTime.now().microsecondsSinceEpoch;
    var path = "/storage/emulated/0/Download/image-$dateTime.jpg";
    var file = File(path);
    var res = await get(Uri.parse(url));
    file.writeAsBytes(res.bodyBytes);
  }

}
