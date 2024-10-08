import 'dart:io';
import 'package:cphi/splash/splash_binding.dart';
import 'package:cphi/utils/shared_preferences_helper.dart';
import 'package:cphi/view/localDatabase/SharedPrefController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:cphi/routes/app_pages.dart';
import 'package:cphi/theme/app_colors.dart';
import 'package:cphi/theme/app_theme.dart';
import 'api_repository/api_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'fcm/firebase_options.dart';
import 'globalController/authentication_manager.dart';

void main() async {
  final context = SecurityContext.defaultContext;
  context.allowLegacyUnsafeRenegotiation = true;
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.white, // navigation bar color
    statusBarColor: Colors.white, // status bar color
    statusBarIconBrightness: Brightness.light, // Dark icons for a light background
    statusBarBrightness: Brightness.light,
  ));


  // await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  await Firebase.initializeApp(
      name: "hitachi-2023", options: DefaultFirebaseOptions.currentPlatform);
  await SharedPreferencesHelper().init(); // Initialize SharedPreferences

  Get.put<AuthenticationManager>(AuthenticationManager());
  Get.putAsync<ApiService>(() => ApiService().init());
  // Initialize and register ApiService
  // Get.putAsync<ApiService>(() async {
  //   final apiService = ApiService();
  //   await apiService.init(); // Wait for init to complete
  //   return apiService;
  // });
  // FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  runApp(const MyApp());
}

@pragma('vm:entry-point')
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: '',
      initialRoute: Routes.INITIAL,
      initialBinding: SplashBinding(),
      getPages: AppPages.pages,
      debugShowCheckedModeBanner: false,
      theme: appThemeData,
    );
  }
}
