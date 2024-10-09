import 'dart:convert';
import 'dart:io';
import 'package:cphi/model/common_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../api_repository/app_url.dart';
import '../../../routes/app_pages.dart';
import '../../../routes/my_constant.dart';
import '../splash/model/config_model.dart';
import '../../../api_repository/api_service.dart';

const PLAY_STORE_URL =
    'https://play.google.com/store/apps/details?id=com.dreamcast.enwention';

const APP_STORE_URL =
    'https://apps.apple.com/us/app/enwesion-2023/id6478390205';

class AuthenticationManager extends GetxController {
  var iosAppVersion = 1;
  late final SharedPreferences _prefs;
  SharedPreferences get prefs => _prefs;
  var _currAppVersion = "";
  get currAppVersion => _currAppVersion;
  final isLogged = false.obs;
  final loading = false.obs;
  final isRemember = false.obs;
  ConfigModel _configModel = ConfigModel();
  late String _dcTimezone;
  late String _osName;

  var qrBadge = "".obs;
  var hotelImage = "".obs;
  var dosDontPdf = "".obs;
  var venuePdf = "".obs;
  var showBadge = false.obs;
  String _platformVersion = "";
  late String _dc_device;

  String get dc_device => _dc_device;

  String get platformVersion => _platformVersion;

  String get osName => _osName;

  String get dcTimezone => _dcTimezone;
  String pageName = "";
  String pageId = "";
  String currentReceiverId = "";

  late final FirebaseDatabase _firebaseDatabase;
  FirebaseDatabase get firebaseDatabase => _firebaseDatabase;

  ConfigModel get configModel => _configModel;
  // var aiMatchList = <AiFields>[].obs;
  set configModel(ConfigModel value) {
    _configModel = value;
    update();
  }

  initSharedPref() async {
    _prefs = await SharedPreferences.getInstance();
  }

  @override
  onInit() async {
    super.onInit();
    // _firebaseMessaging = FirebaseMessaging.instance;
    _firebaseDatabase = FirebaseDatabase.instance;
    fcmSubscribe();
    getInitialInfo();
    // final pushNotificationService = PushNotificationService(_firebaseMessaging);
    // pushNotificationService.initialise();
    // getFcmTokenFrom();
    initSharedPref();
  }

  void fcmSubscribe() {
    // print("firebase calling=====");
    // _firebaseDatabase.databaseURL =
    //     "https://dreamcast-event--2024-default-rtdb.firebaseio.com/";
    // firebaseDatabase
    //     .ref("${AppUrl.defaultFirebaseNode}/endPoint")
    //     .onValue
    //     .listen((event) {
    //   if (event.snapshot.value != null) {
    //     final json = event.snapshot.value as Map<dynamic, dynamic>;
    //     if (json["flutter"] != null && json["flutter"].toString().isNotEmpty) {
    //       AppUrl.baseUrl = json["flutter"];
    //     }
    //   }
    // });
  }

  // Future<void> getConfigDetail() async {
  //   ConfigModel model = await apiService.getConfigInit();
  //   if (model!.status! && model!.code == 200) {
  //     configModel = model!;
  //   }
  // }

  //ho
  Future<void> getContactDetailApi(dynamic body) async {
    loading(true);
    // HomePageModel? model = await apiService.getContactDetail(body);
    loading(false);
    // if (model!.status! && model!.code == 200) {
    //   // if (model.body?.aiFields != null) {
    //   //   aiMatchList.clear();
    //   //   aiMatchList.addAll(model.body!.aiFields!);
    //   //   aiMatchList.refresh();
    //   // }
    // }
  }

  Future<void> deleteYourAccount() async {
    // loading(true);
    // CommonModel? model = await apiService.deleteAccount();
    // loading(false);
    // if (model!.status! && model!.code == 200) {
    // //  UiHelper.showSuccessMsg(null, model?.body?.message ?? "");
    //   Get.offNamedUntil(Routes.LOGIN, (route) => false);
    // }
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      _platformVersion = "1"; // FkUserAgent.userAgent!;
    } on PlatformException {
      _platformVersion = 'Failed to get platform version.';
    }
  }

  getInitialInfo() {
    _osName = Platform.isAndroid ? "Android" : "ios";
    DateTime dateTime = DateTime.now();
    _dcTimezone = dateTime.timeZoneOffset.toString();
    final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    _dc_device = data.size.shortestSide < 600 ? 'mobile' : 'tablet';
    // _getClientInformation();
  }

  //force update..
}
