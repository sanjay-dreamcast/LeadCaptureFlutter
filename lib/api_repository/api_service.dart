import 'dart:convert';
import 'package:cphi/model/guide_model.dart';
import 'package:cphi/routes/my_constant.dart';
import 'package:cphi/api_repository/app_url.dart';
import 'package:cphi/view/localDatabase/event_data_Model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/state_manager.dart';
import '../globalController/authentication_manager.dart';
import '../model/badge_model.dart';
import '../model/common_model.dart';
import '../model/pages_model.dart';
import '../routes/app_pages.dart';
import '../theme/app_colors.dart';
import '../view/customerWidget/regularTextView.dart';
import '../view/localDatabase/LoginController.dart';
import '../view/localDatabase/contactDetailModel.dart';
import '../view/localDatabase/localDataModel.dart';
import '../view/qrCode/model/unique_code_model.dart';
import '../view/qrCode/model/user_detail_model.dart';
import 'digestauthclient.dart';
import 'package:mime/mime.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:http_parser/http_parser.dart';

import 'exceptions.dart';

ApiService apiService = Get.find<ApiService>();

class ApiService extends GetxService {
  //late RestClient _restClient;
  late final AuthenticationManager _authManager;
  var isDialogShow = false;
  var cphiHeaders;
  var authHeader;
  var DIGEST_AUTH_USERNAME = "";
  var DIGEST_AUTH_PASSWORD = "";
  Future<ApiService> init() async {
    DIGEST_AUTH_USERNAME = "41ab073b088c9b12b231643ff6f437d9";
    DIGEST_AUTH_PASSWORD = "9381edb30e889126282379eae2bf2aee";
    _authManager = Get.find();
    cphiHeaders = {
      "Content-Type": "application/json",
      "X-Api-Key": "%2BiR%2Ftt9g8E1tk1%2BDCJgiO7i5XrI%3D",
      "X-Requested-With": "XMLHttpRequest",
      "dc-timezone": "-330",
      "User-Agent": _authManager.osName.toLowerCase(),
      "Dc-OS": _authManager.osName.toLowerCase(),
      "Dc-Device": _authManager.dc_device.toLowerCase(),
      "Dc-Platform": "flutter",
      "Dc-OS-Version": _authManager.platformVersion,
      "DC-UUID": "",
      "version": "3"
    };
    // _restClient = RestClient();
    // _restClient.init();
    return this;
  }

  dynamic getHeaders() {
    //dc-device-id, dc-os, dc-os-version
    authHeader = {
      "Content-Type": "application/json",
      "X-Api-Key": '%2BiR%2Ftt9g8E1tk1%2BDCJgiO7i5XrI%3D',
      "X-Requested-With": "XMLHttpRequest",
      "dc-timezone": "-330",
      "Cookie": _authManager.prefs.getString("token") ?? "",
      "User-Agent": _authManager.osName.toLowerCase(),
      "Dc-OS": _authManager.osName.toLowerCase(),
      "Dc-Device": _authManager.dc_device.toLowerCase(),
      "Dc-Platform": "flutter",
      "Dc-OS-Version": _authManager.platformVersion,
      "DC-UUID": "",
      "version": "3"
    };
    return authHeader!;
  }

  dynamic getHeadersPart() {
    //dc-device-id, dc-os, dc-os-version
    authHeader = {
      "Content-Type": "multipart/form-data",
      "X-Api-Key": '%2BiR%2Ftt9g8E1tk1%2BDCJgiO7i5XrI%3D',
      "X-Requested-With": "XMLHttpRequest",
      "dc-timezone": "-330",
      "Cookie": _authManager.prefs.getString("token") ?? "",
      "User-Agent": _authManager.osName.toUpperCase(),
      "Dc-OS": _authManager.osName,
      "Dc-Device": _authManager.dc_device,
      "Dc-Platform": "flutter",
      "Dc-OS-Version": _authManager.platformVersion,
      "DC-UUID": "",
      "Dc-App-Version": "1",
      "version": "3"
    };
    return authHeader!;
  }

//   Future<ConfigModel> getConfigInit() async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .get(Uri.parse(AppUrl.getConfig), headers: cphiHeaders)
//               .timeout(const Duration(seconds: 20));
//       print(response.body);
//       return ConfigModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       checkException(e);
//       rethrow;
//     }
//   }
//
//   Future<SignupFieldModel> getSignupField() async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .get(Uri.parse(AppUrl.getFields), headers: cphiHeaders)
//               .timeout(const Duration(seconds: 20));
//       print(response.body);
//       return SignupFieldModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       checkException(e);
//       rethrow;
//     }
//   }
//
//   Future<PagesModel> getPagesContent(dynamic map) async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .post(
//                   Uri.parse(
//                     AppUrl.pages,
//                   ),
//                   body: map,
//                   headers: getHeaders())
//               .timeout(const Duration(seconds: 20));
//       return PagesModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       checkException(e);
//       rethrow;
//     }
//   }
//
//   Future<LoginResponseModel?> login(dynamic body) async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .post(Uri.parse(AppUrl.login),
//                   headers: cphiHeaders, body: jsonEncode(body))
//               .timeout(const Duration(seconds: 20));
//
//       if (json.decode(response.body)["status"]) {
//         _authManager.prefs
//             .setString("token", response.headers['set-cookie'].toString());
//       } else {
//         _authManager.prefs.setString("token", "");
//       }
//       return LoginResponseModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       checkException(e);
//       rethrow;
//     }
//   }
//
//   Future<LoginResponseModel?> loginWithOtp(dynamic body) async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .post(Uri.parse(AppUrl.loginByOtp),
//                   headers: cphiHeaders, body: jsonEncode(body))
//               .timeout(const Duration(seconds: 20));
//
//       if (json.decode(response.body)["status"]) {
//         _authManager.prefs
//             .setString("token", response.headers['set-cookie'].toString());
//       } else {
//         _authManager.prefs.setString("token", "");
//       }
//       return LoginResponseModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       checkException(e);
//       rethrow;
//     }
//   }
//
//   Future<CommonModel> shareVerificationCode(dynamic body) async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .post(Uri.parse(AppUrl.shareVerificationCode),
//                   headers: cphiHeaders, body: jsonEncode(body))
//               .timeout(const Duration(seconds: 20));
//
//       /* _authManager.prefs
//           .setString("token", response.headers['set-cookie'].toString());*/
//       return CommonModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       checkException(e);
//       rethrow;
//     }
//   }
//
  Future<ContactDetailModel> getContactDetail(dynamic body) async {
    try {
      final response =
          await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
              .post(Uri.parse(AppUrl.contactListApi),
                  headers: cphiHeaders, body: jsonEncode(body))
              .timeout(const Duration(seconds: 20));
      print(response.body);
      return ContactDetailModel.fromJson(json.decode(response.body));
    } catch (e) {
      checkException(e);
      rethrow;
    }
  }
  Future<EventApiResponse> getEventsList(dynamic body) async {
    // Prepare your headers
    Map<String, String> headerParams = {
      "Authorization": "Bearer " + "",
      "dc-timezone": getCurrentTimezoneOffsetInMinutes().toString(),
    };

    try {
      final response = await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
          .get(Uri.parse(AppUrl.eventList),
          headers: headerParams,)
          .timeout(const Duration(seconds: 20));

      print('Raw response body: ${response.body}'); // Log the raw response

      // Attempt to parse the JSON response
      return EventApiResponse.fromJson(json.decode(response.body));
    } catch (e) {
      print('Error: $e'); // Log the error for debugging
      checkException(e);
      rethrow;
    }

  }
  Future<ApiResponse> verifyUserName(dynamic body) async {
    try {
      final response =
      await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
          .post(Uri.parse(AppUrl.verifyUserName),
          headers: cphiHeaders, body: jsonEncode(body))
          .timeout(const Duration(seconds: 20));
      print(response.body);
      return ApiResponse.fromJson(json.decode(response.body));
    } catch (e) {
      checkException(e);
      rethrow;
    }
  }

  // Future<EventApiResponse> getEventsList(dynamic body) async {
  //   // Prepare your headers
  //   Map<String, String> headerParams = {
  //     "Authorization": "",
  //     "dc-timezone": getCurrentTimezoneOffsetInMinutes().toString(),
  //     "Content-Type": "application/json",
  //   };
  //
  //   try {
  //     final response = await http.post(
  //       Uri.parse(AppUrl.eventList),
  //       headers: headerParams,
  //       body: jsonEncode(body),
  //     ).timeout(const Duration(seconds: 20));
  //
  //     print('Raw response body: ${response.body}'); // Log the raw response
  //
  //     // Check if the response status code is OK (200)
  //     if (response.statusCode == 200) {
  //       // Attempt to parse the JSON response
  //       return EventApiResponse.fromJson(json.decode(response.body));
  //     } else {
  //       throw Exception('Failed to load events: ${response.reasonPhrase}');
  //     }
  //   } catch (e) {
  //     print('Error: $e'); // Log the error for debugging
  //     // Optionally, you can handle different types of exceptions here
  //     throw e; // Re-throw the error after logging
  //   }
  // }


  void checkException(Object exception) {
    if (exception is ServerException) {
      Get.snackbar(
        backgroundColor: Colors.red,
        colorText: Colors.white,
        "Http status error [500]",
        (exception as ServerException).message.toString(),
      );
      print((exception as ServerException).statusCode);
    } else if (exception is ClientException) {
      Get.snackbar(
        backgroundColor: Colors.red,
        colorText: Colors.white,
        "Http status error [500]",
        (exception as ServerException).message.toString(),
      );
    } else if (exception is HttpException) {
      Get.snackbar(
        backgroundColor: Colors.red,
        colorText: Colors.white,
        "Network",
        "Please check your internet connection.",
      );
    }
  }
  int getCurrentTimezoneOffsetInMinutes() {
    // Get the current timezone offset in milliseconds
    final Duration offset = DateTime.now().timeZoneOffset;

    // Convert the offset to minutes
    final int offsetInMinutes = offset.inMinutes;

    return offsetInMinutes;
  }
//
//   Future<CommonModel> updatePassword(dynamic body) async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .post(Uri.parse(AppUrl.updatePassword),
//                   headers: cphiHeaders, body: jsonEncode(body))
//               .timeout(const Duration(seconds: 20));
//       print(response.body);
//       return CommonModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       checkException(e);
//       rethrow;
//     }
//   }
//
//   Future<SignupResponseModel?> signupApi(
//       dynamic body, List<FormFields> list) async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .post(Uri.parse(AppUrl.signup),
//                   headers: cphiHeaders, body: jsonEncode(body))
//               .timeout(const Duration(seconds: 20));
//       print(response.body);
//       return SignupResponseModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       checkException(e);
//       rethrow;
//     }
//
//     final uri = Uri.parse(AppUrl.signup);
//     final req = http.MultipartRequest("POST", uri);
//
//     req.headers.addAll(cphiHeaders);
//
//     req.fields.addAll(body);
//     try {
//       http.Response response = await http.Response.fromStream(
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .send(req)
//               .timeout(const Duration(seconds: 20)));
//       print(response.body);
//       return SignupResponseModel.fromJson(
//           json.decode(response.body.toString()));
//     } catch (e) {
//       debugPrint(e.toString());
//     }
//     return null;
//   }
//
//   Future<MyPhotoModel?> searchAiPhoto(dynamic body, String imageFile) async {
//     final uri = Uri.parse(AppUrl.seachAiPhototApi);
//     final req = http.MultipartRequest("POST", uri);
//     if (true) {
//       if (imageFile != null) {
//         final mimeTypeData =
//             lookupMimeType(imageFile ?? "", headerBytes: [0xFF, 0xD8])!
//                 .split('/');
//         print("image addedd");
//         req.files.add(await http.MultipartFile.fromPath("image", imageFile,
//             contentType: MediaType(mimeTypeData[0], mimeTypeData[1])));
//       }
//     }
//     req.fields.addAll(body);
//     print(req.files);
//     print(req.fields);
//     print(req);
//     req.headers.addAll(authHeader);
//     try {
//       http.Response response = await http.Response.fromStream(
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .send(req)
//               .timeout(const Duration(seconds: 50)));
//       print("response of search image${response.body}");
//       return MyPhotoModel.fromJson(json.decode(response.body.toString()));
//     } catch (e) {
//       debugPrint(e.toString());
//     }
//     return null;
//   }
//
//   Future<ProfileUpdateModel?> updateProfile(dynamic body) async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .post(
//                   body: jsonEncode(body),
//                   Uri.parse(AppUrl.updateProfile),
//                   headers: getHeaders())
//               .timeout(const Duration(seconds: 20));
//       return ProfileUpdateModel.fromJson(json.decode(response.body.toString()));
//     } catch (e) {
//       debugPrint(e.toString());
//     }
//     return null;
//   }
//
//   Future<ProfileUpdateModel?> removeImage() async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .post(
//                   body: jsonEncode({"avatar": ""}),
//                   Uri.parse(AppUrl.updatePicture),
//                   headers: getHeaders())
//               .timeout(const Duration(seconds: 20));
//       return ProfileUpdateModel.fromJson(json.decode(response.body.toString()));
//     } catch (e) {
//       debugPrint(e.toString());
//     }
//     return null;
//   }
//
//   Future<ProfileUpdateModel?> updateImage(dynamic imagePath) async {
//     final uri = Uri.parse(AppUrl.updatePicture);
//     final req = http.MultipartRequest("POST", uri);
//     final mimeTypeData =
//         lookupMimeType(imagePath ?? "", headerBytes: [0xFF, 0xD8])!.split('/');
//     if (imagePath.toString().isNotEmpty) {
//       req.files.add(await http.MultipartFile.fromPath("avatar", imagePath,
//           contentType: MediaType(mimeTypeData[0], mimeTypeData[1])));
//     }
//     print(req);
//     req.headers.addAll(getHeaders());
//     try {
//       http.Response response = await http.Response.fromStream(
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .send(req)
//               .timeout(const Duration(seconds: 20)));
//       print(response.body);
//       print(response.headers);
//       print(response.request);
//       return ProfileUpdateModel.fromJson(json.decode(response.body.toString()));
//     } catch (e) {
//       debugPrint(e.toString());
//     }
//   }
//
//   Future<ProfileModel> getProfile() async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .get(Uri.parse(AppUrl.getProfileData), headers: getHeaders())
//               .timeout(const Duration(seconds: 20));
//
//       //final cookies = response.headers['set-cookie'];
//       if (ProfileModel.fromJson(json.decode(response.body))?.code == 440) {
//         tokenExpire();
//       }
//       return ProfileModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       checkException(e);
//
//       rethrow;
//     }
//   }
//
//   Future<ProfileModel> getProfileByRole({requestBody, endUrl}) async {
//     print(requestBody);
//     print(Uri.parse("${endUrl}/get"));
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .post(Uri.parse("${endUrl}/get"),
//                   headers: getHeaders(), body: jsonEncode(requestBody))
//               .timeout(const Duration(seconds: 20));
//       //final cookies = response.headers['set-cookie'];
//       if (ProfileModel.fromJson(json.decode(response.body)).code == 440) {
//         tokenExpire();
//       }
//
//       print(response.body);
//       return ProfileModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       checkException(e);
//
//       rethrow;
//     }
//   }
//
//   Future<SignupCategoryModel?> getSignupCategory() async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .get(Uri.parse(AppUrl.signupCategory), headers: cphiHeaders)
//               .timeout(const Duration(seconds: 20));
//       return SignupCategoryModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       checkException(e);
//       rethrow;
//     }
//   }
//
//   Future<AboutUsModel> getGalleryFrame() async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .get(Uri.parse(AppUrl.galleryFrame), headers: getHeaders())
//               .timeout(const Duration(seconds: 20));
//       if (AboutUsModel.fromJson(json.decode(response.body)).code == 440) {
//         tokenExpire();
//       }
//       return AboutUsModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       checkException(e);
//       rethrow;
//     }
//   }
//
//   Future<StateResponseModel?> getStateByCountry(String country) async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .get(Uri.parse("${AppUrl.getStatesByCountry}/$country"),
//                   headers: cphiHeaders)
//               .timeout(const Duration(seconds: 20));
//
//       return StateResponseModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       checkException(e);
//       rethrow;
//     }
//   }
//
//   Future<CityResponseModel?> getCityByCountry(
//       String country, String state) async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .get(Uri.parse("${AppUrl.getCityByState}/$country/$state"),
//                   headers: cphiHeaders)
//               .timeout(const Duration(seconds: 20));
//
//       return CityResponseModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       checkException(e);
//       rethrow;
//     }
//   }
//
//   Future<CreateProfileModel?> profileField(String categoryId) async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .get(Uri.parse(AppUrl.createProfile), headers: getHeaders())
//               .timeout(const Duration(seconds: 20));
//
//       if (CreateProfileModel.fromJson(json.decode(response.body)).code == 440) {
//         tokenExpire();
//       }
//       return CreateProfileModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       checkException(e);
//       rethrow;
//     }
//   }
//
//   Future<HomePageModel> getHomePageData() async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .get(Uri.parse(AppUrl.getConfigDetail), headers: getHeaders())
//               .timeout(const Duration(seconds: 20));
//       if (HomePageModel.fromJson(json.decode(response.body))?.code == 440) {
//         tokenExpire();
//       }
//       print("Home response=====");
//       print(response.body);
//       return HomePageModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       checkException(e);
//       rethrow;
//     }
//   }
//
//   Future<ScheduleModel> getTodaySession() async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .get(Uri.parse(AppUrl.getTodaySession), headers: getHeaders())
//               .timeout(const Duration(seconds: 20));
//       if (ScheduleModel.fromJson(json.decode(response.body))?.code == 440) {
//         tokenExpire();
//       }
//       return ScheduleModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       checkException(e);
//       rethrow;
//     }
//   }
//
//   Future<CommonModel> deleteAccount() async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .get(Uri.parse(AppUrl.deleteAccount), headers: getHeaders())
//               .timeout(const Duration(seconds: 20));
//       if (CommonModel.fromJson(json.decode(response.body))?.code == 440) {
//         tokenExpire();
//       }
//       return CommonModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       checkException(e);
//       rethrow;
//     }
//   }
//
//   Future<AllsponsorModel> getAllSponsors(dynamic requestBody) async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .post(Uri.parse(AppUrl.allSponsors),
//                   headers: getHeaders(), body: jsonEncode(requestBody))
//               .timeout(const Duration(seconds: 20));
//       if (AllsponsorModel.fromJson(json.decode(response.body)).head?.code ==
//           440) {
//         tokenExpire();
//       }
//       return AllsponsorModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       checkException(e);
//       rethrow;
//     }
//   }
//
//   Future<TimezoneModel> getTimezone() async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .get(Uri.parse(AppUrl.getTimezone), headers: getHeaders())
//               .timeout(const Duration(seconds: 20));
//       if (TimezoneModel.fromJson(json.decode(response.body)).head?.code ==
//           440) {
//         tokenExpire();
//       }
//       return TimezoneModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       checkException(e);
//       rethrow;
//     }
//   }
//
//   Future<CommonModel> setTimezone(timezone) async {
//     var jsonBody = {"timezone": timezone};
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .post(
//                   body: jsonBody,
//                   Uri.parse(AppUrl.setTimezone),
//                   headers: getHeaders())
//               .timeout(const Duration(seconds: 20));
//       if (CommonModel.fromJson(json.decode(response.body))?.code == 440) {
//         tokenExpire();
//       }
//       return CommonModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   /*Exhibitor api*/
//
//   Future<ExhibitorsModel> getExhibitorsList(dynamic body) async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .post(Uri.parse("${AppUrl.exhibitorsListApi}/search"),
//                   headers: getHeaders(), body: jsonEncode(body))
//               .timeout(const Duration(seconds: 20));
//       if (ExhibitorsModel.fromJson(json.decode(response.body))?.code == 440) {
//         tokenExpire();
//       }
//       print(response.body);
//       return ExhibitorsModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       print(e);
//       rethrow;
//     }
//   }
//
//   Future<PhotoListModel> getAiPhotoList(dynamic body) async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .post(Uri.parse("${AppUrl.eventPhotoListApi}"),
//                   headers: getHeaders(), body: jsonEncode(body))
//               .timeout(const Duration(seconds: 20));
//       if (RepresentativeModel.fromJson(json.decode(response.body))?.code ==
//           440) {
//         tokenExpire();
//       }
//       return PhotoListModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       print(e);
//       rethrow;
//     }
//   }
//
//   Future<GalleryModel> getGalleryList(dynamic body) async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .get(
//                 Uri.parse("${AppUrl.galleryListApi}/get"),
//                 headers: getHeaders(),
//               )
//               .timeout(const Duration(seconds: 20));
//       if (GalleryModel.fromJson(json.decode(response.body))?.code == 440) {
//         tokenExpire();
//       }
//       return GalleryModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       print(e);
//       rethrow;
//     }
//   }
//
//   Future<ExhibitorsModel> getExhibitorsAiMatches(dynamic body) async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .post(Uri.parse("${AppUrl.exhibitorsListApi}/search"),
//                   headers: getHeaders(), body: jsonEncode(body))
//               .timeout(const Duration(seconds: 20));
//       //debugPrint("ai matched-----${response.body}");
//       if (ExhibitorsModel.fromJson(json.decode(response.body))?.code == 440) {
//         tokenExpire();
//       }
//       return ExhibitorsModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   Future<ExhibitorsFilterModel> getExhibitorsFilterList(requestBody) async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .post(Uri.parse("${AppUrl.exhibitorsListApi}/getFilters"),
//                   body: jsonEncode(requestBody), headers: getHeaders())
//               .timeout(const Duration(seconds: 20));
//       if (ExhibitorsFilterModel.fromJson(json.decode(response.body))?.code ==
//           440) {
//         tokenExpire();
//       }
//       print("==============================");
//       print(response.request);
//       print(response.body);
//       return ExhibitorsFilterModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   Future<ExhibitorsDetailsModel> getExhibitorsDetail(dynamic body) async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .post(Uri.parse("${AppUrl.exhibitorsListApi}/get"),
//                   headers: getHeaders(), body: jsonEncode(body))
//               .timeout(const Duration(seconds: 20));
//       if (ExhibitorsDetailsModel.fromJson(json.decode(response.body))?.code ==
//           440) {
//         tokenExpire();
//       }
//       return ExhibitorsDetailsModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   Future<HotelDetailModel> getHotelDetail() async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .get(Uri.parse(AppUrl.hotelDetail), headers: getHeaders())
//               .timeout(const Duration(seconds: 20));
//       if (HotelDetailModel.fromJson(json.decode(response.body))?.code == 440) {
//         tokenExpire();
//       }
//       return HotelDetailModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   Future<BookmarkCommonModel> bookmarkToExhibitor(
//     dynamic body,
//   ) async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .put(
//                   body: jsonEncode(body),
//                   Uri.parse(AppUrl.bookmarkToExhibitor),
//                   headers: getHeaders())
//               .timeout(const Duration(seconds: 20));
//       if (BookmarkCommonModel.fromJson(json.decode(response.body))?.code ==
//           440) {
//         tokenExpire();
//       }
//
//       return BookmarkCommonModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   Future<BookmarkCommonModel> bookmarkToUsers(
//     dynamic body,
//   ) async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .put(
//                   body: jsonEncode(body),
//                   Uri.parse(AppUrl.usersBookmarkApi),
//                   headers: getHeaders())
//               .timeout(const Duration(seconds: 20));
//       print(response.body);
//       if (BookmarkCommonModel.fromJson(json.decode(response.body))?.code ==
//           440) {
//         tokenExpire();
//       }
//
//       return BookmarkCommonModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   Future<BookmarkCommonModel> bookmarkToSpeaker(
//     dynamic body,
//   ) async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .put(
//                   body: jsonEncode(body),
//                   Uri.parse(AppUrl.speakerBookmarkApi),
//                   headers: getHeaders())
//               .timeout(const Duration(seconds: 20));
//       print(response.body);
//       if (BookmarkCommonModel.fromJson(json.decode(response.body))?.code ==
//           440) {
//         tokenExpire();
//       }
//
//       return BookmarkCommonModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   Future<ExhibitorsDocumentModel> getExhibitorsDocument(dynamic body) async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .post(Uri.parse(AppUrl.exhibitorsVideoApi),
//                   headers: getHeaders(), body: jsonEncode(body))
//               .timeout(const Duration(seconds: 20));
//       if (ExhibitorsDocumentModel.fromJson(json.decode(response.body))
//               .head
//               ?.code ==
//           440) {
//         tokenExpire();
//       }
//       return ExhibitorsDocumentModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   //get list of bookmark ids
//   Future<BookmarkIdsModel> getBookmarkIds(dynamic body) async {
//     try {
//       debugPrint(jsonEncode(body));
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .post(
//                   body: jsonEncode(body),
//                   Uri.parse(AppUrl.listByWebinarIds),
//                   headers: getHeaders())
//               .timeout(const Duration(seconds: 20));
//       print(response.body);
//       ;
//       if (BookmarkIdsModel.fromJson(json.decode(response.body))?.code == 440) {
//         tokenExpire();
//       }
//       return BookmarkIdsModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   Future<BookmarkCommonModel> bookmarkToDocument(
//     dynamic body,
//     dynamic id,
//   ) async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .put(Uri.parse(AppUrl.exhibitorsDocumentToggleApi),
//                   headers: getHeaders(), body: jsonEncode(body))
//               .timeout(const Duration(seconds: 20));
//       //_authManager.saveToken(response.headers['set-cookie']);
//       if (BookmarkCommonModel.fromJson(json.decode(response.body))?.code ==
//           440) {
//         tokenExpire();
//       }
//       return BookmarkCommonModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   Future<BookmarkCommonModel> askQuestion(
//     dynamic body,
//     dynamic id,
//   ) async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .post(
//                   Uri.parse("${AppUrl.exhibitorsDocumentApi + id}/askQuestion"),
//                   headers: getHeaders(),
//                   body: jsonEncode(body))
//               .timeout(const Duration(seconds: 20));
//       if (BookmarkCommonModel.fromJson(json.decode(response.body))?.code ==
//           440) {
//         tokenExpire();
//       }
//       return BookmarkCommonModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   Future<BookmarkCommonModel> sessionAskQuestion(
//       {dynamic body, dynamic url}) async {
//     try {
//       final response = await DigestAuthClient(
//               DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//           .post(Uri.parse(url), headers: getHeaders(), body: jsonEncode(body))
//           .timeout(const Duration(seconds: 20));
//       if (BookmarkCommonModel.fromJson(json.decode(response.body))?.code ==
//           440) {
//         tokenExpire();
//       }
//       return BookmarkCommonModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   Future<ProductListModel> getExhibitorsProduct(
//       dynamic body, dynamic id) async {
//     try {
//       final response = await DigestAuthClient(
//               DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//           .post(
//               Uri.parse("${AppUrl.exhibitorsDocumentApi + id}/product/search"),
//               headers: getHeaders(),
//               body: jsonEncode(body))
//           .timeout(const Duration(seconds: 20));
//       if (ProductListModel.fromJson(json.decode(response.body)).head?.code ==
//           440) {
//         tokenExpire();
//       }
//       return ProductListModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   Future<ExhibitorTeamListModel> getExhibitorsRepresentatives(
//       dynamic body) async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .post(Uri.parse(AppUrl.exhibitorsRepresentativesApi),
//                   headers: getHeaders(), body: jsonEncode(body))
//               .timeout(const Duration(seconds: 20));
//       if (ExhibitorTeamListModel.fromJson(json.decode(response.body))
//               .head
//               ?.code ==
//           440) {
//         tokenExpire();
//       }
//       return ExhibitorTeamListModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   Future<ProductFilterModel> getExhibitorsProductFilter(
//       dynamic body, dynamic id) async {
//     try {
//       final response = await DigestAuthClient(
//               DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//           .post(
//               Uri.parse(
//                   "${AppUrl.exhibitorsDocumentApi + id}/product/getFilters"),
//               headers: getHeaders(),
//               body: jsonEncode(body))
//           .timeout(const Duration(seconds: 20));
//       if (ProductFilterModel.fromJson(json.decode(response.body)).head?.code ==
//           440) {
//         tokenExpire();
//       }
//       return ProductFilterModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   /*representative*/
//   Future<TimeslotModel> getTimeslot(dynamic body) async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .post(Uri.parse(AppUrl.userMeetingSlotsGet),
//                   headers: getHeaders(), body: jsonEncode(body))
//               .timeout(const Duration(seconds: 20));
//       if (TimeslotModel.fromJson(json.decode(response.body)).head?.code ==
//           440) {
//         tokenExpire();
//       }
//       return TimeslotModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   Future<CornerSlotModel> getCornerSlot(dynamic body) async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .get(Uri.parse(AppUrl.connectCornerSlot), headers: getHeaders())
//               .timeout(const Duration(seconds: 20));
//       if (CornerSlotModel.fromJson(json.decode(response.body)).head?.code ==
//           440) {
//         tokenExpire();
//       }
//       return CornerSlotModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   /*get meeting data*/
//   Future<MeetingModel> getMeetingList(dynamic body) async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .post(Uri.parse(AppUrl.userMeetingsSearch),
//                   headers: getHeaders(), body: jsonEncode(body))
//               .timeout(const Duration(seconds: 20));
//
//       if (MeetingModel.fromJson(json.decode(response.body))?.code == 440) {
//         tokenExpire();
//       }
//       return MeetingModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   /*get meeting filter*/
//   Future<MeetingFilterModel> getMeetingFilterList() async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .get(Uri.parse(AppUrl.userMeetingFilter), headers: getHeaders())
//               .timeout(const Duration(seconds: 20));
//       if (MeetingFilterModel.fromJson(json.decode(response.body))?.code ==
//           440) {
//         tokenExpire();
//       }
//       return MeetingFilterModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   /*get meeting filter*/
//   Future<MeetingDetailModel> getMeetingDetail(dynamic body) async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .post(Uri.parse(AppUrl.userMeetingDetail),
//                   headers: getHeaders(), body: jsonEncode(body))
//               .timeout(const Duration(seconds: 20));
//       print(response.body);
//       if (MeetingDetailModel.fromJson(json.decode(response.body))?.code ==
//           440) {
//         tokenExpire();
//       }
//       return MeetingDetailModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   /*get meeting filter*/
//   Future<MeetingParticipantModel> getMeetingParticipant(dynamic body) async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .post(Uri.parse(AppUrl.userMeetingsParticipants),
//                   headers: getHeaders(), body: jsonEncode(body))
//               .timeout(const Duration(seconds: 20));
//       if (MeetingParticipantModel.fromJson(json.decode(response.body))?.code ==
//           440) {
//         tokenExpire();
//       }
//       return MeetingParticipantModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   /*accpet or reject meeting action*/
//   Future<BookmarkCommonModel> actionAgainstRequest(dynamic body) async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .post(Uri.parse(AppUrl.actionAgainstRequest),
//                   headers: getHeaders(), body: jsonEncode(body))
//               .timeout(const Duration(seconds: 20));
//
//       if (BookmarkCommonModel.fromJson(json.decode(response.body))?.code ==
//           440) {
//         tokenExpire();
//       }
//       print(response.body);
//       return BookmarkCommonModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   /*get collegues List*/
//   Future<ColleaguesModel> getColleaguesList(dynamic body) async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .post(Uri.parse(AppUrl.userMeetingColleagues),
//                   headers: getHeaders(), body: jsonEncode(body))
//               .timeout(const Duration(seconds: 20));
//       if (ColleaguesModel.fromJson(json.decode(response.body)).head?.code ==
//           440) {
//         tokenExpire();
//       }
//       return ColleaguesModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   /*send Invitation to  another user */
//   Future<BookmarkCommonModel> sendJoinRequest(dynamic body) async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .post(Uri.parse(AppUrl.sendJoinRequest),
//                   headers: getHeaders(), body: jsonEncode(body))
//               .timeout(const Duration(seconds: 20));
//
//       if (BookmarkCommonModel.fromJson(json.decode(response.body))?.code ==
//           440) {
//         tokenExpire();
//       }
//       return BookmarkCommonModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   Future<RepresentativeModel> getRepresentativeList(dynamic body) async {
//     print(body);
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .post(Uri.parse("${AppUrl.usersListApi}/search"),
//                   headers: getHeaders(), body: jsonEncode(body))
//               .timeout(const Duration(seconds: 20));
//       if (RepresentativeModel.fromJson(json.decode(response.body))?.code ==
//           440) {
//         tokenExpire();
//       }
//       print(response.body);
//       return RepresentativeModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   /*connect corner List*/
//   Future<ConnectCornerModel> getConnectCornerList(dynamic body) async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .post(Uri.parse(AppUrl.connectCornerList),
//                   headers: getHeaders(), body: jsonEncode(body))
//               .timeout(const Duration(seconds: 20));
//       if (ConnectCornerModel.fromJson(json.decode(response.body)).head?.code ==
//           440) {
//         tokenExpire();
//       }
//
//       return ConnectCornerModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   /*start for speakers module*/
//   Future<SpeakersModel> getSpeakersApi(dynamic body) async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .post(Uri.parse("${AppUrl.speakerListApi}/search"),
//                   headers: getHeaders(), body: jsonEncode(body))
//               .timeout(const Duration(seconds: 20));
//       if (SpeakersModel.fromJson(json.decode(response.body))?.code == 440) {
//         tokenExpire();
//       }
//       return SpeakersModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   Future<SpeakersFilterModel> getSpeakerFilterList(
//       Map<String, String> requestBody) async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .get(Uri.parse("${AppUrl.speakerListApi}/getFilters"),
//                   headers: getHeaders())
//               .timeout(const Duration(seconds: 20));
//
//       if (RepresentativeFilterModel.fromJson(json.decode(response.body))
//               ?.code ==
//           440) {
//         tokenExpire();
//       }
//       return SpeakersFilterModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   Future<SpeakersDetail> getSpeakerDetail(dynamic body) async {
//     try {
//       print(body);
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .post(Uri.parse("${AppUrl.speakerListApi}/get"),
//                   headers: getHeaders(), body: jsonEncode(body))
//               .timeout(const Duration(seconds: 20));
//       //_authManager.saveToken(response.headers['set-cookie']);
//       if (SpeakersDetail.fromJson(json.decode(response.body))?.code == 440) {
//         tokenExpire();
//       }
//       return SpeakersDetail.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   Future<RepresentativeModel> getOneToOneList(dynamic body) async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .post(Uri.parse("${AppUrl.usersListApi}/search"),
//                   headers: getHeaders(), body: jsonEncode(body))
//               .timeout(const Duration(seconds: 20));
//       if (RepresentativeModel.fromJson(json.decode(response.body))?.code ==
//           440) {
//         tokenExpire();
//       }
//
//       return RepresentativeModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   Future<ContactListModel> getContactList(dynamic body) async {
//     print(body);
//     print("${AppUrl.contactListApi}/get");
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .post(Uri.parse("${AppUrl.contactListApi}/get"),
//                   headers: getHeaders(), body: jsonEncode(body))
//               .timeout(const Duration(seconds: 20));
//       print(body);
//       if (RepresentativeModel.fromJson(json.decode(response.body))?.code ==
//           440) {
//         tokenExpire();
//       }
//       return ContactListModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   Future<RepresentativeFilterModel> getRepresentativeFilterList(
//       Map<String, String> requestBody) async {
//     try {
//       print(requestBody);
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .post(Uri.parse("${AppUrl.usersListApi}/getFilters"),
//                   headers: getHeaders(), body: jsonEncode(requestBody))
//               .timeout(const Duration(seconds: 20));
//
//       print(response.body);
//       ;
//       if (RepresentativeFilterModel.fromJson(json.decode(response.body))
//               ?.code ==
//           440) {
//         tokenExpire();
//       }
//       return RepresentativeFilterModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   Future<RepresentativeDetail> getRepresentativeDetail(dynamic body) async {
//     print(Uri.parse("${AppUrl.usersListApi}/get"));
//     print(body);
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .post(Uri.parse("${AppUrl.usersListApi}/get"),
//                   headers: getHeaders(), body: jsonEncode(body))
//               .timeout(const Duration(seconds: 20));
//       print(response.body);
//       //_authManager.saveToken(response.headers['set-cookie']);
//       if (RepresentativeDetail.fromJson(json.decode(response.body))?.code ==
//           440) {
//         tokenExpire();
//       }
//       return RepresentativeDetail.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   //send First chat request
//   Future<ChatRequestModel> sendChatRequest(
//     dynamic requestBody,
//   ) async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .post(
//                   body: jsonEncode(requestBody),
//                   Uri.parse(AppUrl.sendChatRequest),
//                   headers: getHeaders())
//               .timeout(const Duration(seconds: 20));
//       print(response.body);
//       if (ChatRequestModel.fromJson(json.decode(response.body))?.code == 440) {
//         tokenExpire();
//       }
//       return ChatRequestModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   Future<ChatRequestStatusModel> chatRequestStatus(
//     dynamic requestBody,
//   ) async {
//     try {
//       print(requestBody);
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .post(
//                   body: jsonEncode(requestBody),
//                   Uri.parse(AppUrl.getChatRequestStatus),
//                   headers: getHeaders())
//               .timeout(const Duration(seconds: 20));
//       print(response.body);
//       if (ChatRequestStatusModel.fromJson(json.decode(response.body))?.code ==
//           440) {
//         tokenExpire();
//       }
//       return ChatRequestStatusModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   Future<BookmarkCommonModel> bookmarkToRepresentative(
//       {dynamic id, baseUrl}) async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .put(Uri.parse(baseUrl + id + "/bookmark/toggle"),
//                   headers: getHeaders())
//               .timeout(const Duration(seconds: 20));
//       if (BookmarkCommonModel.fromJson(json.decode(response.body))?.code ==
//           440) {
//         tokenExpire();
//       }
//       return BookmarkCommonModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   Future<BookmarkCommonModel> bookAppointment(
//     dynamic requestBody,
//   ) async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .post(
//                   body: jsonEncode(requestBody),
//                   Uri.parse(AppUrl.bookAppointment),
//                   headers: getHeaders())
//               .timeout(const Duration(seconds: 20));
//       if (BookmarkCommonModel.fromJson(json.decode(response.body))?.code ==
//           440) {
//         tokenExpire();
//       }
//
//       return BookmarkCommonModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   Future<RepresentativeModel> getAiMatchUser(dynamic body) async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .post(Uri.parse("${AppUrl.usersListApi}/search"),
//                   body: jsonEncode(body), headers: getHeaders())
//               .timeout(const Duration(seconds: 20));
//       if (RepresentativeModel.fromJson(json.decode(response.body))?.code ==
//           440) {
//         tokenExpire();
//       }
//       return RepresentativeModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   /*product*/
//   Future<ProductListModel> getProductList(dynamic body) async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .post(Uri.parse(AppUrl.getProductList),
//                   headers: getHeaders(), body: jsonEncode(body))
//               .timeout(const Duration(seconds: 20));
//       if (ProductListModel.fromJson(json.decode(response.body)).head?.code ==
//           440) {
//         tokenExpire();
//       }
//       return ProductListModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   Future<ProductExhibitorModel> getProductExhibitor(dynamic body) async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .post(Uri.parse(AppUrl.getProductExhibitor),
//                   headers: getHeaders(), body: jsonEncode(body))
//               .timeout(const Duration(seconds: 20));
//       if (ProductExhibitorModel.fromJson(json.decode(response.body))
//               .head
//               ?.code ==
//           440) {
//         tokenExpire();
//       }
//       return ProductExhibitorModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   Future<ProductFilterModel> getFilterProduct(dynamic body) async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .post(Uri.parse(AppUrl.getProductFilter),
//                   headers: getHeaders(), body: jsonEncode(body))
//               .timeout(const Duration(seconds: 20));
//       if (ProductFilterModel.fromJson(json.decode(response.body)).head?.code ==
//           440) {
//         tokenExpire();
//       }
//       //_authManager.saveToken(response.headers['set-cookie']);
//       return ProductFilterModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   Future<ProductDetailModel> getProductDetail(dynamic body) async {
//     print(body);
//     print(AppUrl.getProductDetail);
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .post(Uri.parse(AppUrl.getProductDetail),
//                   headers: getHeaders(), body: jsonEncode(body))
//               .timeout(const Duration(seconds: 20));
//       print(response.body);
//       if (ProductDetailModel.fromJson(json.decode(response.body)).head?.code ==
//           440) {
//         tokenExpire();
//       }
//       return ProductDetailModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   Future<BookmarkCommonModel> deleteProductFromSwagBag({productId}) async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .delete(Uri.parse(AppUrl.deleteProductFromSwagBag),
//                   body: jsonEncode({"id": productId}), headers: getHeaders())
//               .timeout(const Duration(seconds: 20));
//
//       if (BookmarkCommonModel.fromJson(json.decode(response.body))?.code ==
//           440) {
//         tokenExpire();
//       }
//       return BookmarkCommonModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   Future<BookmarkCommonModel> addProductByNfcId({nfcId}) async {
//     try {
//       print(nfcId);
//       print(AppUrl.saveProductFromSwagBag);
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .post(Uri.parse(AppUrl.saveProductFromSwagBag),
//                   body: jsonEncode({"code": nfcId}), headers: getHeaders())
//               .timeout(const Duration(seconds: 20));
//
//       if (BookmarkCommonModel.fromJson(json.decode(response.body))?.code ==
//           440) {
//         tokenExpire();
//       }
//       return BookmarkCommonModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   Future<BookmarkCommonModel> viewGallerySave({body}) async {
//     try {
//       print(body);
//       print(AppUrl.viewDocumentProduct);
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .post(Uri.parse(AppUrl.viewDocumentProduct),
//                   body: jsonEncode(body), headers: getHeaders())
//               .timeout(const Duration(seconds: 20));
//       print(response.body);
//       if (BookmarkCommonModel.fromJson(json.decode(response.body))?.code ==
//           440) {
//         tokenExpire();
//       }
//       return BookmarkCommonModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   /*my event bookmark*/
//   Future<BookmarkExhibitorModel> getBookmarkExhibitor(dynamic body) async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .post(
//                   body: jsonEncode(body),
//                   Uri.parse(AppUrl.getBookmarkExhibitor),
//                   headers: getHeaders())
//               .timeout(const Duration(seconds: 20));
//       //_authManager.saveToken(response.headers['set-cookie']);
//       if (BookmarkExhibitorModel.fromJson(json.decode(response.body))
//               .head
//               ?.code ==
//           440) {
//         tokenExpire();
//       }
//       return BookmarkExhibitorModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   Future<BookmarkExhibitorDocumentModel> getBookmarkDocument(
//       dynamic body) async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .post(
//                   body: jsonEncode(body),
//                   Uri.parse(AppUrl.myBookmarkDocument),
//                   headers: getHeaders())
//               .timeout(const Duration(seconds: 20));
//       //_authManager.saveToken(response.headers['set-cookie']);
//       if (BookmarkExhibitorDocumentModel.fromJson(json.decode(response.body))
//               .head
//               ?.code ==
//           440) {
//         tokenExpire();
//       }
//       return BookmarkExhibitorDocumentModel.fromJson(
//           json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   Future<BookmarkExhibitorVideoModel> getBookmarkExhibitorVideo(
//       dynamic body) async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .post(
//                   body: body,
//                   Uri.parse(AppUrl.myBookmarkDocument),
//                   headers: getHeaders())
//               .timeout(const Duration(seconds: 20));
//       if (BookmarkExhibitorVideoModel.fromJson(json.decode(response.body))
//               .head
//               ?.code ==
//           440) {
//         tokenExpire();
//       }
//       return BookmarkExhibitorVideoModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   Future<BookmarkRepresentativeModel> getBookmarkUser(dynamic body) async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .post(
//                   body: jsonEncode(body),
//                   Uri.parse(AppUrl.getUserFavourites),
//                   headers: getHeaders())
//               .timeout(const Duration(seconds: 20));
//
//       if (BookmarkRepresentativeModel.fromJson(json.decode(response.body))
//               .head
//               ?.code ==
//           440) {
//         tokenExpire();
//       }
//       return BookmarkRepresentativeModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   Future<BookmarkAttendeeModel> getBookmarkAttendee(dynamic body) async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .post(
//                   body: jsonEncode(body),
//                   Uri.parse(AppUrl.getBookmarkExhibitor),
//                   headers: getHeaders())
//               .timeout(const Duration(seconds: 20));
//       //_authManager.saveToken(response.headers['set-cookie']);
//       if (BookmarkAttendeeModel.fromJson(json.decode(response.body))
//               .head
//               ?.code ==
//           440) {
//         tokenExpire();
//       }
//       return BookmarkAttendeeModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   Future<BookmarkProductModel> getBookmarkProduct(dynamic body) async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .post(
//                   body: jsonEncode(body),
//                   Uri.parse(AppUrl.myBookmarkProduct),
//                   headers: getHeaders())
//               .timeout(const Duration(seconds: 20));
//       if (BookmarkProductModel.fromJson(json.decode(response.body))
//               .head
//               ?.code ==
//           440) {
//         tokenExpire();
//       }
//       return BookmarkProductModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   Future<CreateRoomModel> sendFirstMessage(
//     dynamic requestBody,
//   ) async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .post(
//                   body: jsonEncode(requestBody),
//                   Uri.parse(AppUrl.createRoom),
//                   headers: getHeaders())
//               .timeout(const Duration(seconds: 20));
//       if (CreateRoomModel.fromJson(json.decode(response.body))?.code == 440) {
//         tokenExpire();
//       }
//       return CreateRoomModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       print(e);
//       rethrow;
//     }
//   }
//
//   Future<PhotoboothModel> getPhotobooth() async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .get(Uri.parse(AppUrl.photobooth), headers: getHeaders())
//               .timeout(const Duration(seconds: 20));
//       if (PhotoboothModel.fromJson(json.decode(response.body)).head?.code ==
//           440) {
//         tokenExpire();
//       }
//       return PhotoboothModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   Future<SwagBagModel> getSwagBag(dynamic jsonRequest) async {
//     print(jsonRequest);
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .post(Uri.parse(AppUrl.swagGuide),
//                   body: jsonEncode(jsonRequest), headers: getHeaders())
//               .timeout(const Duration(seconds: 20));
//       print(response.body);
//
//       if (SwagBagModel.fromJson(json.decode(response.body)).head?.code == 440) {
//         tokenExpire();
//       }
//       return SwagBagModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   Future<SwagBagModel> eventVideoList(dynamic jsonRequest) async {
//     print(jsonRequest);
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .post(Uri.parse(AppUrl.eventVideoList),
//                   body: jsonEncode(jsonRequest), headers: getHeaders())
//               .timeout(const Duration(seconds: 20));
//       print(response.body);
//       print(response.body);
//       if (SwagBagModel.fromJson(json.decode(response.body)).head?.code == 440) {
//         tokenExpire();
//       }
//       return SwagBagModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   Future<FaqModel> getFaqList(dynamic jsonRequest) async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .get(Uri.parse(AppUrl.faqList), headers: getHeaders())
//               .timeout(const Duration(seconds: 20));
//
//       if (FaqModel.fromJson(json.decode(response.body)).head?.code == 440) {
//         tokenExpire();
//       }
//       return FaqModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   Future<GuideModel> getIframe({slug}) async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .get(Uri.parse("${AppUrl.iframe}/$slug"), headers: getHeaders())
//               .timeout(const Duration(seconds: 20));
//       if (GuideModel.fromJson(json.decode(response.body))?.code == 440) {
//         tokenExpire();
//       }
//       print(response.body);
//       return GuideModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   Future<SwagBagBookmarkModel> myBookmarkSwagbag(dynamic jsonRequest) async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .post(Uri.parse(AppUrl.myBookmarkSwagbag),
//                   headers: getHeaders(), body: jsonEncode(jsonRequest))
//               .timeout(const Duration(seconds: 20));
//       if (SwagBagBookmarkModel.fromJson(json.decode(response.body))
//               .head
//               ?.code ==
//           440) {
//         tokenExpire();
//       }
//       //print(response.body);
//       return SwagBagBookmarkModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   Future<BookmarkCommonModel> bookmarkToGuide(dynamic jsonRequest) async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .post(Uri.parse(AppUrl.bookmarkGuide),
//                   headers: getHeaders(), body: jsonEncode(jsonRequest))
//               .timeout(const Duration(seconds: 20));
//
//       if (BookmarkCommonModel.fromJson(json.decode(response.body))?.code ==
//           440) {
//         tokenExpire();
//       }
//       return BookmarkCommonModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   Future<CommonModel> viewSwagbag(dynamic jsonRequest) async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .post(Uri.parse(AppUrl.viewSwagbag),
//                   headers: getHeaders(), body: jsonEncode(jsonRequest))
//               .timeout(const Duration(seconds: 20));
//
//       if (CommonModel.fromJson(json.decode(response.body))?.code == 440) {
//         tokenExpire();
//       }
//       return CommonModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   Future<UniqueCodeModel> getUniqueCode() async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .get(Uri.parse(AppUrl.getUserCode), headers: getHeaders())
//               .timeout(const Duration(seconds: 20));
//       if (UniqueCodeModel.fromJson(json.decode(response.body)).head?.code ==
//           440) {
//         tokenExpire();
//       }
//       return UniqueCodeModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   Future<BadgeModel> getBadge() async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .get(Uri.parse(AppUrl.getBadge), headers: getHeaders())
//               .timeout(const Duration(seconds: 20));
//       if (BadgeModel.fromJson(json.decode(response.body))?.code == 440) {
//         tokenExpire();
//       }
//       return BadgeModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   Future<PhotoboothModel> getSchedule() async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .get(Uri.parse(AppUrl.sessionView), headers: getHeaders())
//               .timeout(const Duration(seconds: 20));
//       if (PhotoboothModel.fromJson(json.decode(response.body)).head?.code ==
//           440) {
//         tokenExpire();
//       }
//       return PhotoboothModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   Future<UserModelModel> getUserDetailByCode(uniqueCode) async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .post(
//                   body: jsonEncode({"code": uniqueCode}),
//                   Uri.parse(AppUrl.getUserDetail),
//                   headers: getHeaders())
//               .timeout(const Duration(seconds: 20));
//       print(response.body);
//       if (UserModelModel.fromJson(json.decode(response.body)).head?.code ==
//           440) {
//         tokenExpire();
//       }
//       return UserModelModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   Future<UniqueCodeModel> saveUserToContact({jsonRequest}) async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .post(
//                   body: jsonEncode(jsonRequest),
//                   Uri.parse(AppUrl.saveContact),
//                   headers: getHeaders())
//               .timeout(const Duration(seconds: 20));
//       if (UniqueCodeModel.fromJson(json.decode(response.body)).head?.code ==
//           440) {
//         tokenExpire();
//       }
//       return UniqueCodeModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   Future<ExportModel> exportContact() async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .get(Uri.parse(AppUrl.exportContact), headers: getHeaders())
//               .timeout(const Duration(seconds: 20));
//       if (ExportModel.fromJson(json.decode(response.body)).head?.code == 440) {
//         tokenExpire();
//       }
//       return ExportModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   Future<CommonModel> sendNotification(
//     dynamic requestBody,
//   ) async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .post(
//                   body: jsonEncode(requestBody),
//                   Uri.parse(AppUrl.sendNotification),
//                   headers: getHeaders())
//               .timeout(const Duration(seconds: 20));
//       if (CommonModel.fromJson(json.decode(response.body)).code == 440) {
//         tokenExpire();
//       }
//       return CommonModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   /*session module start*/
//   Future<ScheduleModel> getSessionList(dynamic body) async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .post(Uri.parse(AppUrl.getSession),
//                   headers: getHeaders(), body: jsonEncode(body))
//               .timeout(const Duration(seconds: 20));
//       if (ScheduleModel.fromJson(json.decode(response.body))?.code == 440) {
//         tokenExpire();
//       }
//       print(response.body);
//       return ScheduleModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       checkException(e);
//       rethrow;
//     }
//   }
//
//   /*get meeting filter*/
//   Future<SessionDetailModel> getSessionDetail(dynamic body) async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .post(Uri.parse(AppUrl.getSessionDetail),
//                   headers: getHeaders(), body: jsonEncode(body))
//               .timeout(const Duration(seconds: 20));
//       if (SessionDetailModel.fromJson(json.decode(response.body))?.code ==
//           440) {
//         tokenExpire();
//       }
//       return SessionDetailModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   /*get meeting filter*/
//   Future<CommonModel> bookSessionSeat(dynamic body) async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .post(Uri.parse(AppUrl.bookSessionSeat),
//                   headers: getHeaders(), body: jsonEncode(body))
//               .timeout(const Duration(seconds: 20));
//       if (CommonModel.fromJson(json.decode(response.body))?.code == 440) {
//         tokenExpire();
//       }
//       return CommonModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   /*get sessions filter*/
//   Future<SessionFilterModel> getSessionsFilter() async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .get(Uri.parse(AppUrl.sessionsFilter), headers: getHeaders())
//               .timeout(const Duration(seconds: 20));
//       if (SessionFilterModel.fromJson(json.decode(response.body))?.code ==
//           440) {
//         tokenExpire();
//       }
//       return SessionFilterModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   Future<SessionFilterModel> getBookingSessionsFilter() async {
//     try {
//       final response = await DigestAuthClient(
//               DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//           .get(Uri.parse(AppUrl.bookingSessionsFilter), headers: getHeaders())
//           .timeout(const Duration(seconds: 20));
//       if (SessionFilterModel.fromJson(json.decode(response.body))?.code ==
//           440) {
//         tokenExpire();
//       }
//       return SessionFilterModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   Future<CommonModel> sendPollResponse(dynamic body) async {
//     try {
//       final response = await DigestAuthClient(
//               DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//           .post(Uri.parse(AppUrl.savePolls), headers: getHeaders(), body: body)
//           .timeout(const Duration(seconds: 20));
//       if (CommonModel.fromJson(json.decode(response.body))?.code == 440) {
//         tokenExpire();
//       }
//       return CommonModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   Future<PollStatusModel> getPollStatus(dynamic body) async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .post(Uri.parse(AppUrl.isPollSubmitted),
//                   headers: getHeaders(), body: jsonEncode(body))
//               .timeout(const Duration(seconds: 20));
//       if (PollStatusModel.fromJson(json.decode(response.body))?.code == 440) {
//         tokenExpire();
//       }
//       print(response.body);
//       return PollStatusModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   Future<BookmarkCommonModel> bookmarkToSession(dynamic body) async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .put(
//                   body: jsonEncode(body),
//                   Uri.parse(AppUrl.bookmarkSessions),
//                   headers: getHeaders())
//               .timeout(const Duration(seconds: 20));
//       if (BookmarkCommonModel.fromJson(json.decode(response.body))?.code ==
//           440) {
//         tokenExpire();
//       }
//       return BookmarkCommonModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   /*session module start*/
//   Future<SessionBookmarkModel> getBookmarkSessionApi(dynamic body) async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .post(Uri.parse(AppUrl.getBookmarkSessions),
//                   headers: getHeaders(), body: jsonEncode(body))
//               .timeout(const Duration(seconds: 20));
//       if (SessionBookmarkModel.fromJson(json.decode(response.body))?.code ==
//           440) {
//         tokenExpire();
//       }
//       return SessionBookmarkModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   /*seat booking module start*/
//   Future<SessionBookmarkModel> getSessionBooking(dynamic body) async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .post(Uri.parse(AppUrl.getBookingSeat),
//                   headers: getHeaders(), body: jsonEncode(body))
//               .timeout(const Duration(seconds: 20));
//
//       if (SessionBookmarkModel.fromJson(json.decode(response.body))?.code ==
//           440) {
//         tokenExpire();
//       }
//       return SessionBookmarkModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   Future<QuestionListModel> getFeedbackList(String url, dynamic body) async {
//     try {
//       final response = await DigestAuthClient(
//               DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//           .post(Uri.parse(url), headers: getHeaders(), body: jsonEncode(body))
//           .timeout(const Duration(seconds: 20));
//       if (QuestionListModel.fromJson(json.decode(response.body))?.code == 440) {
//         tokenExpire();
//       }
//       print(response.body);
//       return QuestionListModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   Future<CommonModel> saveFeedbackApi(dynamic requestBody, String url) async {
//     try {
//       print(requestBody);
//       print(url);
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .post(Uri.parse(url),
//                   headers: getHeaders(), body: jsonEncode(requestBody))
//               .timeout(const Duration(seconds: 20));
//
//       if (CommonModel.fromJson(json.decode(response.body))?.code == 440) {
//         tokenExpire();
//       }
//       return CommonModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   Future<PollsSubmitModel> submitPoll(dynamic requestBody) async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .post(Uri.parse(AppUrl.savePolls),
//                   headers: getHeaders(), body: jsonEncode(requestBody))
//               .timeout(const Duration(seconds: 20));
//       if (PollsSubmitModel.fromJson(json.decode(response.body))?.code == 440) {
//         tokenExpire();
//       }
//       print(response.body);
//       return PollsSubmitModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   Future<QuizSubmitModel> saveQuizApi(dynamic requestBody) async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .post(Uri.parse(AppUrl.savePolls),
//                   headers: getHeaders(), body: jsonEncode(requestBody))
//               .timeout(const Duration(seconds: 20));
//       if (QuizSubmitModel.fromJson(json.decode(response.body))?.code == 440) {
//         tokenExpire();
//       }
//       print(response.body);
//       return QuizSubmitModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   Future<CreatePostModel?> createEventFeed(dynamic body, XFile? file) async {
//     final uri = Uri.parse(AppUrl.feedCreate);
//     final req = http.MultipartRequest("POST", uri);
//
//     if (file != null) {
//       final mimeTypeData =
//           lookupMimeType(file!.path ?? "", headerBytes: [0xFF, 0xD8])!
//               .split('/');
//       req.files.add(await http.MultipartFile.fromPath("media", file.path,
//           contentType: MediaType(mimeTypeData[0], mimeTypeData[1])));
//     }
//     req.fields.addAll(body);
//     req.headers.addAll(authHeader);
//     try {
//       //final response =
//       http.Response response1 = await http.Response.fromStream(
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .send(req)
//               .timeout(const Duration(seconds: 20)));
//
//       if (CreatePostModel.fromJson(json.decode(response1.body)).head?.code ==
//           440) {
//         tokenExpire();
//       }
//       return CreatePostModel.fromJson(json.decode(response1.body.toString()));
//     } catch (e) {
//       debugPrint(e.toString());
//     }
//     return null;
//   }
//
//   Future<FeedDataModel> getFeedList(dynamic requestBody) async {
//     print(requestBody);
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .post(Uri.parse(AppUrl.feedGetList),
//                   headers: getHeaders(), body: jsonEncode(requestBody))
//               .timeout(const Duration(seconds: 20));
//       if (FeedDataModel.fromJson(json.decode(response.body)).head?.code ==
//           440) {
//         tokenExpire();
//       }
//       return FeedDataModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   Future<CreateCommentModel> createFeedComment(dynamic requestBody) async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .post(Uri.parse(AppUrl.feedCommentGetCreate),
//                   headers: getHeaders(), body: jsonEncode(requestBody))
//               .timeout(const Duration(seconds: 20));
//       if (CreateCommentModel.fromJson(json.decode(response.body)).head?.code ==
//           440) {
//         tokenExpire();
//       }
//       return CreateCommentModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   Future<CommonModel> likeFeedPost(dynamic requestBody) async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .post(Uri.parse(AppUrl.feedEmotionsToggleMe),
//                   headers: getHeaders(), body: jsonEncode(requestBody))
//               .timeout(const Duration(seconds: 20));
//       if (CommonModel.fromJson(json.decode(response.body))?.code == 440) {
//         tokenExpire();
//       }
//       return CommonModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   Future<CommonModel> deletePostApi(dynamic requestBody) async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .post(Uri.parse(AppUrl.feedDelete),
//                   headers: getHeaders(), body: jsonEncode(requestBody))
//               .timeout(const Duration(seconds: 20));
//       if (CommonModel.fromJson(json.decode(response.body))?.code == 440) {
//         tokenExpire();
//       }
//       return CommonModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   Future<CommonModel> reportPostApi(dynamic requestBody) async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .post(Uri.parse(AppUrl.feedReport),
//                   headers: getHeaders(), body: jsonEncode(requestBody))
//               .timeout(const Duration(seconds: 20));
//       if (CommonModel.fromJson(json.decode(response.body))?.code == 440) {
//         tokenExpire();
//       }
//       return CommonModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   Future<CommonModel> deleteCommentApi(dynamic requestBody) async {
//     debugPrint(requestBody.toString());
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .post(Uri.parse(AppUrl.feedCommentGetTrash),
//                   headers: getHeaders(), body: jsonEncode(requestBody))
//               .timeout(const Duration(seconds: 20));
//       if (CommonModel.fromJson(json.decode(response.body))?.code == 440) {
//         tokenExpire();
//       }
//       return CommonModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   Future<CommonModel> reportCommentApi(dynamic requestBody) async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .post(Uri.parse(AppUrl.feedCommentGetReport),
//                   headers: getHeaders(), body: jsonEncode(requestBody))
//               .timeout(const Duration(seconds: 20));
//       if (CommonModel.fromJson(json.decode(response.body))?.code == 440) {
//         tokenExpire();
//       }
//       return CommonModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   Future<FeedCommentModel> getFeedCommentList(dynamic requestBody) async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .post(Uri.parse(AppUrl.feedCommentGet),
//                   headers: getHeaders(), body: jsonEncode(requestBody))
//               .timeout(const Duration(seconds: 20));
//       if (FeedCommentModel.fromJson(json.decode(response.body)).head?.code ==
//           440) {
//         tokenExpire();
//       }
//       return FeedCommentModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   Future<LikeFeedModel> getFeedLikeList(dynamic requestBody) async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .post(Uri.parse(AppUrl.feedEmotionsGet),
//                   headers: getHeaders(), body: jsonEncode(requestBody))
//               .timeout(const Duration(seconds: 20));
//       if (LikeFeedModel.fromJson(json.decode(response.body)).head?.code ==
//           440) {
//         tokenExpire();
//       }
//       return LikeFeedModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   Future<InfoDashboardModel> getInfoDashboard({body}) async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .get(Uri.parse(AppUrl.infoDashboardApi), headers: getHeaders())
//               .timeout(const Duration(seconds: 20));
//       print(response.body);
//       return InfoDashboardModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       checkException(e);
//       rethrow;
//     }
//   }
//
//   Future<LeaderBoardModel> getLeaderboard({body}) async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .post(Uri.parse(AppUrl.leaderBoardApi),
//                   body: jsonEncode(body), headers: getHeaders())
//               .timeout(const Duration(seconds: 20));
//       print(response.body);
//       return LeaderBoardModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       checkException(e);
//       rethrow;
//     }
//   }
//
//   Future<EntertainmentModel> getEntertaimentApi(dynamic body) async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .post(Uri.parse("${AppUrl.entertaimentApi}/search"),
//                   headers: getHeaders(), body: jsonEncode(body))
//               .timeout(const Duration(seconds: 20));
//       if (EntertainmentModel.fromJson(json.decode(response.body)).head?.code ==
//           440) {
//         tokenExpire();
//       }
//       return EntertainmentModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   Future<EntertainmentDetail> geEntertaimentDetail(dynamic body) async {
//     try {
//       print(body);
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .post(Uri.parse("${AppUrl.entertaimentApi}/get"),
//                   headers: getHeaders(), body: jsonEncode(body))
//               .timeout(const Duration(seconds: 20));
//       //_authManager.saveToken(response.headers['set-cookie']);
//       if (EntertainmentDetail.fromJson(json.decode(response.body)).head?.code ==
//           440) {
//         tokenExpire();
//       }
//       return EntertainmentDetail.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   Future<MyPhotoModel> myPhotosList({required body}) async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .post(Uri.parse(AppUrl.aiMyImage),
//                   body: jsonEncode(body), headers: getHeaders())
//               .timeout(const Duration(seconds: 20));
//       print(response.body);
//       return MyPhotoModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   Future<SpeakersFilterModel> getEntertaimentFilterList(
//       Map<String, String> requestBody) async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .get(Uri.parse("${AppUrl.entertaimentApi}/getFilters"),
//                   headers: getHeaders())
//               .timeout(const Duration(seconds: 20));
//       if (SpeakersFilterModel.fromJson(json.decode(response.body)).head?.code ==
//           440) {
//         tokenExpire();
//       }
//       print(response.body);
//       return SpeakersFilterModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   /*start photobooth*/
// /*
//   Future<PhotoListModel> getUploadPhotos({required int pageNumber}) async {
//     try {
//      */ /* var formData = <String, dynamic>{};
//       formData["page"] = "1";
//       formData["event_name"] = "narvigate_app";*/ /*
//       final response =
//       await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//           .post(Uri.parse("${AppUrl.aiGalleryList}?page=${pageNumber}&event_name=${MyConstant.photoBoothBucketName}"),
//           headers: getHeaders())
//           .timeout(const Duration(seconds: 20));
//       print(response.body);
//       return PhotoListModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   Future<MyPhotoModel> myPhotosList({required body}) async {
//     try {
//       final response =
//       await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//           .post(Uri.parse(AppUrl.aiMyImage),body: jsonEncode(body),
//           headers: getHeaders())
//           .timeout(const Duration(seconds: 20));
//       print(response.body);
//       return MyPhotoModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       rethrow;
//     }
//   }*/
//   /*End photoboth*/
//
//   tokenExpire() {
//     if (isDialogShow) {
//       return;
//     }
//     isDialogShow = true;
//     Get.defaultDialog(
//         title: "Login Expired",
//         backgroundColor: white,
//         titleStyle: const TextStyle(color: Colors.black),
//         barrierDismissible: false,
//         middleTextStyle: const TextStyle(color: Colors.black),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const RegularTextView(
//               textSize: 16,
//               textAlign: TextAlign.center,
//               text:
//                   "You have either logged out or you were automatically logged out for security purposes",
//               maxLine: 2,
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             MyRoundedButton(
//                 text: "Login Again",
//                 press: () {
//                   isDialogShow = false;
//                   _authManager.prefs.setString("token", "");
//                   _authManager.removeToken();
//                   Get.offNamedUntil(Routes.LOGIN, (route) => false);
//                 })
//           ],
//         ),
//         radius: 10);
//   }
//
//   void checkException(Object exception) {
//     if (exception is ServerException) {
//       Get.snackbar(
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//         "Http status error [500]",
//         (exception as ServerException).message.toString(),
//       );
//       print((exception as ServerException).statusCode);
//     } else if (exception is ClientException) {
//       Get.snackbar(
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//         "Http status error [500]",
//         (exception as ServerException).message.toString(),
//       );
//     } else if (exception is HttpException) {
//       Get.snackbar(
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//         "Network",
//         "Please check your internet connection.",
//       );
//     }
//   }
//
//   //add token to firebase system
//   Future<CommonModel> updateFcmToken(dynamic body) async {
//     try {
//       final response =
//           await DigestAuthClient(DIGEST_AUTH_USERNAME, DIGEST_AUTH_PASSWORD)
//               .post(Uri.parse(AppUrl.updateFcm),
//                   headers: getHeaders(), body: jsonEncode(body))
//               .timeout(const Duration(seconds: 20));
//       return CommonModel.fromJson(json.decode(response.body));
//     } catch (e) {
//       checkException(e);
//       rethrow;
//     }
//   }
}
