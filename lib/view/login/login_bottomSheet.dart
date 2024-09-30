
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../api_repository/api_service.dart';
import '../../model/Status.dart';
import '../../theme/app_colors.dart';
import '../../theme/strings.dart';
import '../localDatabase/LoginController.dart';

class LoginBottomSheet extends StatefulWidget {
  final ValueChanged<String> onSuccess;

  const LoginBottomSheet({super.key, required this.onSuccess});

  @override
  State<LoginBottomSheet> createState() => _LoginBottomSheetState();
}

class _LoginBottomSheetState extends State<LoginBottomSheet> {
  final TextEditingController _otpController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  String errorMessage = '';
  final LoginController loginController = Get.put(LoginController(Get.find<ApiService>()));

  void validateEmail(String email) {
    if (email.isEmpty) {
      setState(() {
        errorMessage = 'Please enter email';
      });
    } else if (!_isValidEmail(email)) {
      setState(() {
        errorMessage = 'Please enter a valid email';
      });
    } else {
      setState(() {
        errorMessage = '';
      });
      loginController.verifyUser({"email": email}, context).then((_) {
        // Update state on successful verification
        if (loginController.verifyUserResource.value.status == Status.success) {
          loginController.setOtpVisible(true); // Show OTP container
        }
      });
    }
  }

  bool _isValidEmail(String email) {
    final RegExp emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Stack(
        children: [
          // Main content of the bottom sheet
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: 50,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(2),
                ),
                margin: const EdgeInsets.only(bottom: 5.0, top: 10),
              ),
              const SizedBox(height: 30),
              Image.asset(
                'assets/images/bg_dreamcast_logo.png',
                width: 200,
                height: 45,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 1),
              const Text(
                'Lead Capture',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: blue_20,
                  fontSize: 18.0,
                  fontStyle: FontStyle.italic,
                  fontFamily: 'figtree_medium_italic',
                ),
              ),
              const SizedBox(height: 20),
              // Switch statement to handle loading and error states
              Obx(() {
                switch (loginController.verifyUserResource.value.status) {
                  case Status.error:
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/ic_event.png',
                              width: 24,
                              height: 24,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              loginController.verifyUserResource.value.message ?? 'No user found',
                              style: const TextStyle(
                                color: blackGrey,
                                fontSize: 20,
                                fontFamily: "figtree_semibold",
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  case Status.success:
                  // Return an empty widget if no loader or error is needed
                    return SizedBox.shrink();
                  default:
                    return SizedBox.shrink(); // Handle any unexpected cases
                }
              }),
              // Using Obx to reactively update the UI based on isOtpVisible
              Obx(() {
                return loginController.isOtpVisible.value
                    ? OtpContainer(
                  otpController: _otpController,
                  errorMessage: errorMessage,
                  loginController: loginController,
                  onVerify: (otp) {
                    // Add your OTP verification logic here
                  },
                )
                    : LoginContainer(
                  emailController: emailController,
                  errorMessage: errorMessage,
                  onLogin: validateEmail,
                );
              }),
            ],
          ),
          // Universal Loader - Overlay on top of the bottom sheet
          Obx(() {
            if (loginController.verifyUserResource.value.status == Status.loading) {
              return Positioned.fill(
                child: UniversalLoader(), // Show full-screen loader
              );
            } else {
              return SizedBox.shrink(); // Hide when not loading
            }
          }),
        ],
      ),
    );
  }
}




class OtpContainer extends StatelessWidget {
  final TextEditingController otpController;
  final String errorMessage;
  final ValueChanged<String> onVerify;
  final LoginController loginController;
  const OtpContainer({
    Key? key,
    required this.otpController,
    required this.errorMessage,
    required  this.loginController,
    required this.onVerify,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: 17, right: 17, top: 15, bottom: 40),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 35),
      decoration: BoxDecoration(
        color: white20color,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Verify OTP',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: blackGrey,
              fontSize: 25.0,
              fontWeight: FontWeight.w500,
              fontFamily: 'figtree_semibold',
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Please enter the OTP sent to your email',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: blackGrey,
              fontSize: 14.0,
              fontFamily: 'figtree_regular',
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: otpController,
            decoration: const InputDecoration(
              labelText: 'OTP',
              labelStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: 16,
                fontWeight: FontWeight.w400,
                fontFamily: "figtree_medium",
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                  width: 1.0,
                ),
              ),
            ),
            cursorColor: Colors.black,
            keyboardType: TextInputType.number, // Ensure only numeric input
          ),
          const SizedBox(height: 16),
          Visibility(
            visible: errorMessage.isNotEmpty,
            child: Text(
              errorMessage,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 12.0,
                fontFamily: 'figtree_medium',
              ),
            ),
          ),
          const SizedBox(height: 5),
          GestureDetector(
            onTap: () => {
              loginController.setOtpVisible(false)
              // onVerify(otpController.text)
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
              decoration: const BoxDecoration(
                color: blackGrey,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              margin: EdgeInsets.only(top: 10),
              child: const Text(
                "Verfyotp", // Ensure this string is defined in your MyStrings
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  fontFamily: "figtree_semibold",
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
class LoginContainer extends StatelessWidget {
  final TextEditingController emailController;
  final String errorMessage;
  final ValueChanged<String> onLogin;

  const LoginContainer({
    Key? key,
    required this.emailController,
    required this.errorMessage,
    required this.onLogin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: 17, right: 17, top: 15, bottom: 40),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 35),
      decoration: BoxDecoration(
        color: white20color,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Login',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: blackGrey,
              fontSize: 25.0,
              fontWeight: FontWeight.w500,
              fontFamily: 'figtree_semibold',
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Welcome, Please enter your login details',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: blackGrey,
              fontSize: 14.0,
              fontFamily: 'figtree_regular',
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
              labelStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: 16,
                fontWeight: FontWeight.w400,
                fontFamily: "figtree_medium",
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                  width: 1.0,
                ),
              ),
            ),
            cursorColor: Colors.black,
          ),
          const SizedBox(height: 16),
          Visibility(
            visible: errorMessage.isNotEmpty,
            child: Text(
              errorMessage,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 12.0,
                fontFamily: 'figtree_medium',
              ),
            ),
          ),
          const SizedBox(height: 5),
          GestureDetector(
            onTap: () => onLogin(emailController.text),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
              decoration: const BoxDecoration(
                color: blackGrey,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              margin: EdgeInsets.only(top: 10),
              child: const Text(
                MyStrings.logIn2,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  fontFamily: "figtree_semibold",
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class UniversalLoader extends StatefulWidget {
  @override
  _UniversalLoaderState createState() => _UniversalLoaderState();
}

class _UniversalLoaderState extends State<UniversalLoader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54, // Dim background
      child: Center(
        child: Container(
          width: 60.0, // Adjust the width as needed
          height: 60.0, // Adjust the height as needed
          decoration: BoxDecoration(
            color: Colors.white, // Background color of the circle
            shape: BoxShape.circle, // Make the container circular
          ),
          child: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black), // Change color if needed
            ),
          ),
        ),
      ),
    );
  }
}

