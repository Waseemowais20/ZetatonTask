import 'package:permission_handler/permission_handler.dart';

// Request permission storage
Future<bool> requestStoragePermission() async {
  PermissionStatus status = await Permission.storage.request();
  bool access = false;
  print('Permission: ${status.isGranted}');
  if (status.isGranted) {
    access = true;
  }
  return access;
}

// Return permission status
Future<bool> checkPermission() async {
  var status = await Permission.storage.status;
  return status.isGranted;
}
