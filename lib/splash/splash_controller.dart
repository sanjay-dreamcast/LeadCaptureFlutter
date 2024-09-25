import 'package:cphi/view/Dashboard/dashboardView.dart';
import 'package:cphi/view/localDatabase/LocalContactPage.dart';
import 'package:get/get.dart';
import 'package:cphi/routes/app_pages.dart';

class SplashController extends GetxController {
  var loading = true.obs;

  @override
  void onInit() {
    nextScreen();
    super.onInit();
  }

  nextScreen() async {
    Future.delayed(const Duration(seconds: 3), () {
      Get.offAndToNamed(DashboardPage.routeName);
    });
  }
}
