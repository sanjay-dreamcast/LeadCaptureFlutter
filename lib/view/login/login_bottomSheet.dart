
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pinput/pinput.dart';
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
  String otpErrorMessage = '';
  bool _isDialogVisible = false; // Add this line

  final LoginController loginController = Get.put(LoginController(Get.find<ApiService>()));

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Stack(
        children: [
          // Main content of the bottom sheet
          SingleChildScrollView(
            child: Column(
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
                // Obx(() {
                //   switch (loginController.verifyUserResource.value.status) {
                //     case Status.error:
                //     // Check if the dialog is already visible
                //       if (!_isDialogVisible) {
                //         _isDialogVisible = true; // Set the flag to true
                //         FocusScope.of(context).unfocus(); // Dismiss the keyboard
                //
                //         // Show the AlertDialog
                //
                //       }
                //       return SizedBox.shrink(); // Return an empty widget while showing the dialog
                //
                //     case Status.success:
                //       return SizedBox.shrink(); // Return an empty widget if no loader or error is needed
                //
                //     default:
                //       return SizedBox.shrink(); // Handle any unexpected cases
                //   }
                // }),


                /*Obx(() {
                  switch (loginController.verifyUserResource.value.status) {
                    case Status.error:
                      FocusScope.of(context).unfocus(); // Add this line
                      // Show the AlertDialog
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        // _showErrorDialog(context, loginController.verifyUserResource.value.message);
                        UniversalAlertDialog.showAlertDialog(context,
                            message: loginController.verifyUserResource.value.message ,
                            isNegativeButtonVisible: false);
                      });
                      return SizedBox.shrink(); // Return an empty widget while showing the dialog

                    case Status.success:
                    // Return an empty widget if no loader or error is needed
                      return SizedBox.shrink();
                    default:
                      return SizedBox.shrink(); // Handle any unexpected cases
                  }
                }), */
                // Using Obx to reactively update the UI based on isOtpVisible
                Obx(() {
                  return loginController.isOtpVisible.value
                      ? OtpContainer(
                    otpController: _otpController,
                    errorMessage: otpErrorMessage,
                    loginController: loginController,
                    onVerify: (otp) {
                      // Add your OTP verification logic here
                    },
                  ) : LoginContainer(
                    emailController: emailController,
                    errorMessage: errorMessage,
                    loginController: loginController,
                    onLogin: (email){
                      loginController.validateEmail(email);
                    },
                  );
                }),
              ],
            ),
          ),
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
          // backButton(context),
          const Text(
            'OTP Verification',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: blackGrey,
              fontSize: 22.0,
              fontWeight: FontWeight.w500,
              fontFamily: 'figtree_semibold',
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Please type a OTP verification code send to',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: blackGrey,
              fontSize: 14.0,
              fontFamily: 'figtree_regular',
            ),
          ),
          const SizedBox(height: 10),
          _otpPin(context),
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
                "Verify & Proceed", // Ensure this string is defined in your MyStrings
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
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

  Widget _otpPin(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 46,
      height: 46,
      textStyle: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(8),
      ),
    );
    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Colors.black,width: 1.7),
      borderRadius: BorderRadius.circular(8),
    );
    return Pinput(
      length: 6,
        defaultPinTheme:defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      onCompleted: (pin) => {
        print("pin--> $pin")},
      onChanged: (pin) => {
        print("pin onChanged--> $pin")},
    );
  }

  Widget backButton(BuildContext context) {
    return GestureDetector(
      onTap: (){}, // Handle button press
      child: Container(
        margin: const EdgeInsets.only(left: -8.0, top: -5.0), // Equivalent of layout margins
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon (ImageView equivalent)
            Container(
              padding: const EdgeInsets.all(5.0), // Equivalent to ImageView padding
              child: Image.asset(
                'assets/ic_back.png', // Use your asset image (ic_back equivalent)
                width: 25,
                height: 25,
              ),
            ),
            const SizedBox(width: 5), // Space between the icon and text
            // Text
            const Text(
              'Back', // Equivalent of android:text="@string/back"
              style: TextStyle(
                fontSize: 14, // Equivalent to android:textSize
                fontFamily: 'FigtreeSemibold', // Equivalent to android:fontFamily
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class LoginContainer extends StatelessWidget {
  final TextEditingController emailController;
  final String errorMessage;
  final ValueChanged<String> onLogin;
  final LoginController loginController;

  const LoginContainer({
    Key? key,
    required this.emailController,
    required this.errorMessage,
    required  this.loginController,
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
          Obx(() {
            return Visibility(
              visible: loginController.errorMessage.isNotEmpty,
              child: Text(
                loginController.errorMessage.value,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 12.0,
                  fontFamily: 'figtree_medium',
                ),
              ),
            );
          }),
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
          width: 60.0,
          height: 60.0,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black), // Change color if needed
            ),
          ),
        ),
      ),
    );
  }
}
