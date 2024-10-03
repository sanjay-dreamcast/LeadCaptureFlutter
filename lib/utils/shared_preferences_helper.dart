import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/user_data.dart';

class SharedPreferencesHelper {
  static const String LOGGED_USER_DATA ="logged_user_data";

  static final SharedPreferencesHelper _instance = SharedPreferencesHelper._internal();
  static SharedPreferences? _prefs;

  // Private constructor
  SharedPreferencesHelper._internal();

  // Factory constructor to return the single instance
  factory SharedPreferencesHelper() {
    return _instance;
  }

  // Initialize SharedPreferences instance
  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }
// Save user data by accepting a UserData object
  Future<void> saveUser(UserData? user) async {
    // Check if user is not null before encoding
    if (user != null) {
      String userJson = jsonEncode(user.toJson());
      await _prefs?.setString(LOGGED_USER_DATA, userJson);
    }
  }

  // Load user data as UserData object
  UserData? getUser() {
    final userJson = _prefs?.getString(LOGGED_USER_DATA);
    if (userJson != null) {
      return UserData.fromJson(jsonDecode(userJson));
    }
    return null; // Return null if no user data found
  }

  // Remove the user object
  Future<void> removeUser() async {
    await _prefs?.remove('user');
  }

  // Clear all data
  Future<void> clear() async {
    await _prefs?.clear();
  }
}
