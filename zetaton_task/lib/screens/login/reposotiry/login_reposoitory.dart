import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zetaton_task/screens/login/models/user_model.dart';
import 'package:zetaton_task/utilites/constants/firebase_collection_enum.dart';
import 'package:zetaton_task/utilites/methods/internet_conictivity.dart';
import 'package:zetaton_task/utilites/session_manager.dart';

class LoginRepository {
  final SessionManager _sessionManager = SessionManager();
  final _db = FirebaseFirestore.instance;

  // Get user data at login process
  Future<UserModel> _getUserData() async {
    await checkInternetConnectivity();
    String? uid = await _sessionManager.getAuthToken();
    DocumentSnapshot? snapShot =
        await _db.collection(FirebaseCollection.users.name).doc(uid).get();

    return UserModel.fromJson(jsonDecode(jsonEncode(snapShot.data() ?? {})));
  }

  // Save user data to shared preferences in session manager
  Future<void> saveUserDataLocally() async {
    await _getUserData().then((value) async {
      await _sessionManager.setFirstName(value.firstName!);
      await _sessionManager.setLastName(value.lastName!);
      await _sessionManager.setPhoneNumber(value.phoneNumber!);
      await _sessionManager.setEmail(value.email!);
    });
  }
}

LoginRepository loginRepository = LoginRepository();
