import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:zetaton_task/constants/strings.dart';
import 'package:zetaton_task/utilites/widgets/custom_toast.dart';
import 'package:zetaton_task/utilites/methods/shared_methods.dart';

// Check users connectivity on his device
Future<void> checkInternetConnectivity() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    CustomToast.show(
        SharedMethods.materialKey.currentContext!, AppStrings.noInternet);
  }
}

// Return connection status
Future<bool> internetConnected() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    return false;
  } else {
    return true;
  }
}
