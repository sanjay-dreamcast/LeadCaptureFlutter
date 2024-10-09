






import 'dart:async';
import 'dart:convert';

import 'package:cphi/model/BaseApiModel.dart';
import 'package:cphi/model/user_data.dart';
import 'package:cphi/theme/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../api_repository/api_service.dart';
import '../../model/EmailErrorbody.dart';
import '../../model/Resource.dart';
import '../../utils/UniversalAlertDialog.dart';
import '../../utils/connectivity_helper.dart';
import '../../utils/shared_preferences_helper.dart';
import 'SharedPrefController.dart';
class LoginController extends GetxController {
  final ApiService apiService;
  LoginController(this.apiService);
  var isOtpVisible = false.obs; // Observable variable to manage OTP visibility
  // Reactive variable to manage the state of the API call (loading, success, error)
  var verifyUserResource = Resource<EmailErrorBody>.initial().obs;
  final Sharedprefcontroller sharedPrefController =
  Get.put(Sharedprefcontroller());
  var errorMessage = ''.obs; // Observable email error message
  var otpErrorMessage = ''.obs; // Observable otp error message
  var pinCode = ''.obs; // Observable PIN code
  var verifyOtpResource = Resource<UserData>.initial().obs;
  var emailId = ''.obs;
  var isLoginButtonVisible = true.obs; // Initially, the button is visible

  var resendTimer = 0.obs; // Countdown timer
  var isResendEnabled = true.obs; // Enable/Disable Resend OTP button
  @override
  void onInit() {
    super.onInit();
    SharedPreferencesHelper().init(); // Initialize SharedPreferences
    checkUserData();
  }
  void toggleOtpVisibility() {
    isOtpVisible.value = !isOtpVisible.value; // Toggle the visibility
  }
  void setOtpVisible(bool visible) {
    isOtpVisible.value = visible; // Set visibility directly
  }
  // Method to check user data in SharedPreferences
  Future<void> checkUserData() async {
    UserData? savedUser = await SharedPreferencesHelper().getUser();
    print("userSaved: ${savedUser != null ? savedUser.toJson() : 'No user data found'}");
    isLoginButtonVisible.value = savedUser != null; // Set to true if user exists, false otherwise
  }

  void updatePin(String pin) {
    pinCode.value = pin;
  }



  Future<void> verifyUser(dynamic body, BuildContext context,{bool isResendOtp = false}) async {
    // Set to loading state initially
    verifyUserResource.value = Resource.loading();

    bool hasInternet = await ConnectivityHelper.checkInternetConnection();
    if (!hasInternet) {
      verifyUserResource.value = Resource.error("No internet connection.");
      return;
    }

    try {
      BaseApiModel<EmailErrorBody>? model = await apiService.verifyUserName(body);

      if (model.status ==true && model.statusCode == 200) {
        // Handle success
        setOtpVisible(true); // Show OTP container
        verifyUserResource.value = Resource.success( message: model.message);
        if(isResendOtp){
          startResendOtpTimer(); // Start timer
          WidgetsBinding.instance.addPostFrameCallback((_) {
            UniversalAlertDialog.showAlertDialog(
              context,
              title: "Success!",
              message: verifyUserResource.value.message,
              isNegativeButtonVisible: false,
            ).then((_) {
              // Reset the flag when the dialog is dismissed
            });
          });
        }
        // Optionally, perform further actions with model.body if needed
      } else {
        // Handle error
        print("verifyUserResource erroe");
        verifyUserResource.value = Resource.error(
          model.data?.emailError ?? model.message ?? MyStrings.someErrorOccurred,
          data: model.data,
        );
        WidgetsBinding.instance.addPostFrameCallback((_) {
          UniversalAlertDialog.showAlertDialog(
            context,
            message: verifyUserResource.value.message,
            isNegativeButtonVisible: false,
          ).then((_) {
            // Reset the flag when the dialog is dismissed
          });
        });
      }
    } catch (e) {
      print("verifyUserResource catch $e");
      // Handle exceptions or unexpected errors
      verifyUserResource.value = Resource.error(MyStrings.somethingWentWrong);
    }
  }

  void validateEmail(String email,{bool isResendOtp = false}) {
    emailId.value = email;
    if (email.isEmpty) {
      errorMessage.value = 'Please enter email';
    } else if (!_isValidEmail(email)) {
      errorMessage.value = 'Please enter a valid email';
    } else {
      errorMessage.value = '';
      verifyUser({"email": email}, Get.context!,isResendOtp:isResendOtp); // Trigger the API call
    }
  }
  void validateOtp() {
    String  otp = pinCode.value;
    if (otp.isEmpty) {
      otpErrorMessage.value = 'Please enter OTP';
    } else if (otp.length<6) {
      otpErrorMessage.value = 'Enter a valid 6-digit OTP.';
    } else {
      otpErrorMessage.value = '';
      verifyOtp({"email": emailId.value,"verification_code":otp}, Get.context!); // Trigger the API call
    }
  }

  Future<void> verifyOtp(dynamic body, BuildContext context) async {
    // Set to loading state initially
    verifyOtpResource.value = Resource.loading();

    bool hasInternet = await ConnectivityHelper.checkInternetConnection();
    if (!hasInternet) {
      verifyOtpResource.value = Resource.error(MyStrings.NoInternetconnected);
      return;
    }

    try {
      // Assuming UserModel is the type for the body
      BaseApiModel<UserData> model = await apiService.verifyOtp(body);
      if (model.status == true && model.statusCode == 200) {
        // Handle success
        setOtpVisible(true); // Show OTP container
        verifyOtpResource.value = Resource.success(
          data: model.data, // this is userdata
          message: model.message,
        );
       // Print the user data for debugging
        print(verifyOtpResource.value.data);
        // Save UserData to SharedPreferences
        if (model.data != null) {
          sharedPrefController.saveUser(model.data);
          await SharedPreferencesHelper().saveUser(model.data);
        }
        isLoginButtonVisible.value = true; // Show the button after login
        // Await the getUser method to retrieve the saved user data
        UserData? savedUser = await SharedPreferencesHelper().getUser();
        print("userSaved: ${savedUser != null ? savedUser.toJson() : 'No user data found'}");
       // Navigator.of(context).pop();
        Get.offAllNamed('/EventScreen'); //

      } else {
        // Handle error
        verifyOtpResource.value = Resource.error(
          model.data?.verificationCode??model.message ?? MyStrings.someErrorOccurred,
          data: model.data,
        );
        WidgetsBinding.instance.addPostFrameCallback((_) {
          UniversalAlertDialog.showAlertDialog(
            context,
            message: verifyOtpResource.value.message,
            isNegativeButtonVisible: false,
          ).then((_) {
            // Reset the flag when the dialog is dismissed
          });
        });
      }
    } catch (e) {
      print("verifyOtpResource catch $e");
      // Handle exceptions or unexpected errors
      verifyOtpResource.value = Resource.error(MyStrings.somethingWentWrong);
    }
  }
  bool _isValidEmail(String email) {
    // Add your email validation logic here
    final emailRegex = RegExp(r"^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$");
    return emailRegex.hasMatch(email);
  }


  // Start the 23-second timer when OTP is sent or resend is clicked
  void startResendOtpTimer() {
    resendTimer.value = 30; // Set timer to 23 seconds
    isResendEnabled.value = false; // Disable Resend OTP button

    Timer.periodic(Duration(seconds: 1), (timer) {
      if (resendTimer.value == 0) {
        isResendEnabled.value = true; // Enable Resend OTP after countdown
        timer.cancel(); // Stop the timer
      } else {
        resendTimer.value--; // Decrease the timer
      }
    });
  }
}



