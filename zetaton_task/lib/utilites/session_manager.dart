import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  final String authToken = "auth_token";
  final String email = "email";
  final String phone = "phone";
  final String firstName = "first_name";
  final String lastName = "last_name";
  Future<SharedPreferences> pref = SharedPreferences.getInstance();

  // Auth Token Save or get local storage
  Future<void> setAuthToken(String authToken) async =>
      (await pref).setString(this.authToken, authToken);

  Future<String?> getAuthToken() async => (await pref).getString(authToken);

  void clearAuthToken() async => (await pref).remove(authToken);

  // Email Save or get local storage
  Future<void> setEmail(String email) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(this.email, email);
  }

  Future<String?> getEmail() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? email;
    email = pref.getString(this.email);
    return email;
  }

  void clearEmail() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove(email);
  }

  // Phone number Save or get local storage
  Future<void> setPhoneNumber(String phoneNumber) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(this.phone, phoneNumber);
  }

  Future<String?> getPhoneNumber() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? phoneNumber;
    phoneNumber = pref.getString(this.phone);
    return phoneNumber;
  }

  // First name Save or get local storage
  Future<void> setFirstName(String firstName) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(this.firstName, firstName);
  }

  Future<String?> getFirstName() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? firstName;
    firstName = pref.getString(this.firstName);
    return firstName;
  }

  // Last name Save or get local storage
  Future<void> setLastName(String lastName) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(this.lastName, lastName);
  }

  Future<String?> getLastName() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? lastName;
    lastName = pref.getString(this.lastName);
    return lastName;
  }
}
