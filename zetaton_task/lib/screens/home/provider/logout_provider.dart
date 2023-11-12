import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zetaton_task/utilites/session_manager.dart';
import 'package:zetaton_task/utilites/widgets/custom_toast.dart';

class LogoutProvider extends ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  final SessionManager _sessionManager = SessionManager();

  // logout method
  Future<String?> logOut(BuildContext context) async {
    try {
      _auth.signOut();
      _sessionManager.clearAuthToken();
      return 'LogOut';
    } on FirebaseAuthException catch (e) {
      CustomToast.show(context, '$e');
      return e.toString();
    }
  }
}
