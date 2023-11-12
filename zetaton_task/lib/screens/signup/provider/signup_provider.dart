import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:zetaton_task/screens/login/models/user_model.dart';
import 'package:zetaton_task/screens/login/reposotiry/login_reposoitory.dart';
import 'package:zetaton_task/screens/signup/reposoitory/signup_reposotioty.dart';
import 'package:zetaton_task/utilites/methods/internet_conictivity.dart';
import 'package:zetaton_task/utilites/session_manager.dart';

class SignUpProvider extends ChangeNotifier {
  final _sm = SessionManager();
  final _loginRepo = LoginRepository();
  final _signUpRepo = SignUpRepository();
  final _auth = FirebaseAuth.instance;

  bool obscurePassword = true;

  // Show password
  setShowPassword(bool newValue) {
    obscurePassword = newValue;
    notifyListeners();
  }

  bool obscureRePassword = true;

  // Show re password
  setShowRePassword(bool newValue) {
    obscureRePassword = newValue;
    notifyListeners();
  }

  // SignIn Loading
  bool _signInLoading = false;

  bool get signInLoading => _signInLoading;

  _setSignInLoading(bool value) {
    _signInLoading = value;
    notifyListeners();
  }

  // Create account from signup for new user bu firebase
  Future<String?> createAccountWithEmail(
      String email, String password, UserModel userModel) async {
    final value = await internetConnected();
    if (value == true) {
      String errorMessage;
      User? user;
      try {
        _setSignInLoading(true);
        final userCredential = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        user = userCredential.user;
        if (user!.uid.isNotEmpty) {
          userModel.uid = user.uid;
          await _sm.setAuthToken(user.uid);
          _signUpRepo.setUserData(userModel);

          _loginRepo.saveUserDataLocally();
          _setSignInLoading(false);
          return 'Success';
        }
      } on FirebaseAuthException catch (error) {
        _setSignInLoading(false);
        switch (error.code) {
          case "EMAIL_ALREADY_IN_USE":
          case "email-already-in-use":
            errorMessage = "Email already used. Go to login page.";
            break;
          default:
            errorMessage = "Login failed. Please try again.";
            break;
        }
        _setSignInLoading(false);
        return errorMessage;
      }
      _setSignInLoading(false);
      return null;
    } else {
      return 'No Internet';
    }
  }
}
