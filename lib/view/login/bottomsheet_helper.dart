

import 'package:cphi/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../theme/strings.dart';
import 'login_bottomSheet.dart';

class BottomSheetHelper {
  static void showDynamicBottomSheet(BuildContext context,ValueChanged<String> onSuccess,
      ) {
    // Create a StatefulWidget to manage the bottom sheet's state
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only( // <-- SEE HERE
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
      ),
      backgroundColor: Colors.white, // <-- SEE HERE
      builder: (BuildContext context) {
        return  new LoginBottomSheet(onSuccess: onSuccess);
      },
    );
  }
}

/*
class BottomSheetHelper {
  static void showDynamicBottomSheet(BuildContext context) {
    // Create a StatefulWidget to manage the bottom sheet's state
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return _DynamicBottomSheet();
      },
    );
  }
}

class _DynamicBottomSheet extends StatefulWidget {
  @override
  __DynamicBottomSheetState createState() => __DynamicBottomSheetState();
}

class __DynamicBottomSheetState extends State<_DynamicBottomSheet> {
  final EmailController emailController = Get.put(EmailController());

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // Top view line with full width
          Container(
            width: 50,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(2),
            ),
            margin: const EdgeInsets.only(bottom: 5.0, top: 10),
          ),
          const SizedBox(height: 10),
          Image.asset(
            'assets/images/bg_dreamcast_logo.png',
            width: 200,
            height: 45,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 5),
          const Text(
            'Lead Capture',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF0000FF),
              fontSize: 16.0,
              fontStyle: FontStyle.italic,
              fontFamily: 'figtree_medium_italic',
            ),
          ),
          const SizedBox(height: 30),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 40),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Login',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black54,
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
                    color: Colors.black54,
                    fontSize: 14.0,
                    fontFamily: 'figtree_regular',
                  ),
                ),
                const SizedBox(height: 10),
                Obx(() => TextField(
                  onChanged: (value) {
                    emailController.email.value = value;
                  },
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      fontFamily: "figtree_medium",
                    ),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 1.0,
                      ),
                    ),
                  ),
                  cursorColor: Colors.black,
                )),
                const SizedBox(height: 16),
                Obx(() => Text(
                  emailController.errorMessage.value,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 12.0,
                    fontFamily: 'figtree_medium',
                  ),
                )),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    // Validate email when the button is pressed
                    emailController.validateEmail();
                    if (emailController.errorMessage.value.isEmpty) {
                      // Proceed with login or any further action if validation is successful
                      Navigator.of(context).pop(); // Close bottom sheet on success
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
                    decoration: const BoxDecoration(
                      color: Colors.black54,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    margin: EdgeInsets.only(top: 10),
                    child: const Text(
                      'Log In',
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
          ),
        ],
      ),
    );
  }
}

*/
