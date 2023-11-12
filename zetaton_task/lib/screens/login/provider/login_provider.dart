import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:zetaton_task/screens/login/reposotiry/login_reposoitory.dart';
import 'package:zetaton_task/utilites/methods/internet_conictivity.dart';
import 'package:zetaton_task/utilites/session_manager.dart';

class LoginProvider extends ChangeNotifier {

  final SessionManager _sm = SessionManager();
  final LoginRepository _loginRepository = LoginRepository();
  // SignIn Loading
  bool _signInLoading = false;

  bool get signInLoading => _signInLoading;

  _setSignInLoading(bool value) {
    _signInLoading = value;
    notifyListeners();
  }

  bool obscurePassword = true;
  // Password obscure text
  setShowPassword(bool newValue) {
    obscurePassword = newValue;
    notifyListeners();
  }

  final _auth = FirebaseAuth.instance;

  // Sign in from login for user already existt
  Future<String?> signInWithEmailAndPassword(
      String email, String password) async {
    final value = await internetConnected();
    if (value == true) {
      String errorMessage;
      User? user;
      try {
        _setSignInLoading(true);
        final userCredential = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        user = userCredential.user;
        if (user!.uid.isNotEmpty) {
          try {
            await _sm.setAuthToken(_auth.currentUser!.uid);
            _sm.getAuthToken().then((value) {
              print(value);
            });
            _loginRepository.saveUserDataLocally();
          } catch (e) {
            _setSignInLoading(false);
          }
          _setSignInLoading(false);
          return 'Success';
        }
      } on FirebaseAuthException catch (error) {
        print(error.code);
        switch (error.code) {
          case "INVALID_LOGIN_CREDENTIALS":
            errorMessage = 'Invalid login credentials';
            break;
          case "ERROR_WRONG_PASSWORD":
          case "wrong-password":
            errorMessage = "Wrong email/password combination.";
            break;
          case "ERROR_USER_NOT_FOUND":
          case "user-not-found":
            errorMessage = "No user found with this email.";
            break;
          case "ERROR_USER_DISABLED":
          case "user-disabled":
            errorMessage = "User disabled.";
            break;
          case "ERROR_TOO_MANY_REQUESTS":
          case "operation-not-allowed":
            errorMessage = "Too many requests to log into this account.";
            break;
          case "ERROR_OPERATION_NOT_ALLOWED":
            errorMessage = "Server error, please try again later.";
            break;
          case "ERROR_INVALID_EMAIL":
          case "invalid-email":
            errorMessage = "Email address is invalid.";
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
