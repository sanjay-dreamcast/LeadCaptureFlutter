import 'package:cphi/splash/splash_controller.dart';
import 'package:get/get.dart';

import '../api_repository/api_service.dart';

class SplashBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(() => SplashController());
    Get.put<ApiService>(ApiService(), permanent: true);
  }
}
