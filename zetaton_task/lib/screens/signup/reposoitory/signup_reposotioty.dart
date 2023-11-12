import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zetaton_task/screens/login/models/user_model.dart';
import 'package:zetaton_task/utilites/constants/firebase_collection_enum.dart';
import 'package:zetaton_task/utilites/methods/internet_conictivity.dart';
import 'package:zetaton_task/utilites/session_manager.dart';

class SignUpRepository {
  final _db = FirebaseFirestore.instance;

  // Save user data to firebase firestore
  Future<String> setUserData(UserModel userModel) async {
    await checkInternetConnectivity();
    try {
      await _db
          .collection(FirebaseCollection.users.name)
          .doc(userModel.uid)
          .set(userModel.toJson());
      return "UserAdd";
    } on FirebaseException catch (error) {
      return error.toString();
    }
  }
}
