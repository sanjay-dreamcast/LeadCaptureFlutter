






import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../api_repository/api_service.dart';

import 'package:get/get.dart';
import '../../api_repository/api_service.dart';
import '../../model/Resource.dart';
import '../../utils/connectivity_helper.dart';

import 'package:get/get.dart';
import '../../api_repository/api_service.dart';

class LoginController extends GetxController {
  final ApiService apiService;
  var isOtpVisible = false.obs; // Observable variable to manage OTP visibility

  void toggleOtpVisibility() {
    isOtpVisible.value = !isOtpVisible.value; // Toggle the visibility
  }

  void setOtpVisible(bool visible) {
    isOtpVisible.value = visible; // Set visibility directly
  }




  // Reactive variable to manage the state of the API call (loading, success, error)
  var verifyUserResource = Resource<String>.initial().obs;

  LoginController(this.apiService);

  Future<void> verifyUser(dynamic body, BuildContext context) async {
    // Set to loading state initially
    verifyUserResource.value = Resource.loading();

    bool hasInternet = await ConnectivityHelper.checkInternetConnection();
    if (!hasInternet) {
      verifyUserResource.value = Resource.error("No internet connection.");
      return;
    }

    try {
      ApiResponse? model = await apiService.verifyUserName(body);

      if (model.status && model.code == 200) {
        // Handle success
        verifyUserResource.value = Resource.success(model.message); // Update success state
        // Optionally, perform further actions with model.body if needed
      } else {
        // Handle error
        verifyUserResource.value = Resource.error(
          model.message ?? "Error occurred",
          data: model.errorBody?.emailError, // Optional error data if exists
        );
      }
    } catch (e) {
      // Handle exceptions or unexpected errors
      verifyUserResource.value = Resource.error('An error occurred: $e');
    }
  }
}


class ApiResponse {
  final bool status;
  final String message;
  final int code;
  final ErrorBody? errorBody;

  ApiResponse({
    required this.status,
    required this.message,
    required this.code,
    this.errorBody,
  });

  // Factory method to parse JSON and create an instance of ApiResponse
  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      status: json['status'] as bool,
      message: json['message'] as String,
      code: json['code'] as int,
      errorBody: json.containsKey('body') ? ErrorBody.fromJson(json['body']) : null,
    );
  }
}

class ErrorBody {
  final String emailError;

  ErrorBody({required this.emailError});

  // Factory method to parse the error body from JSON
  factory ErrorBody.fromJson(Map<String, dynamic> json) {
    return ErrorBody(
      emailError: json['email'] as String,
    );
  }
}
