




import 'package:get/get.dart';

import '../../model/user_data.dart';
import '../../utils/shared_preferences_helper.dart';


class Sharedprefcontroller extends GetxController {
  var loggedInUser = Rxn<UserData>(); // Reactive variable to hold user data

  @override
  void onInit() {
    super.onInit();
    loadUser();
  }

  // Load user data from SharedPreferences
  void loadUser() {
    print("Hello");
    loggedInUser.value = SharedPreferencesHelper().getUser();
    print("Hello  ${loggedInUser.value}");
  }

  // Save user data to SharedPreferences
  Future<void> saveUser(UserData? user) async {
    await SharedPreferencesHelper().saveUser(user);
    loggedInUser.value = user; // Update reactive variable
  }

  // Remove user data
  Future<void> removeUser() async {
    await SharedPreferencesHelper().removeUser();
    loggedInUser.value = null; // Clear reactive variable
  }
}
