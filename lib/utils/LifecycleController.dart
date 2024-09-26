


import 'dart:ui';

import 'package:get/get.dart';



class LifecycleController extends GetxController {
  var appLifecycleState = "Unknown".obs; // Observable to track the app lifecycle state

  void updateLifecycleState(AppLifecycleState state) {
    // Convert AppLifecycleState to string and update the observable
    appLifecycleState.value = state.toString();
    // Additional logic based on the new state can be added here if needed
  }
}
