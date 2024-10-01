import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UniversalAlertDialog {
  // static void showAlertDialog(
  //     BuildContext context, {
  //       String? message, // Changed to nullable
  //       String? title = "Alert",   // Changed to nullable
  //       String positiveButtonLabel = "Okay",
  //       String negativeButtonLabel = "Cancel",
  //       VoidCallback? onPositivePressed,
  //       VoidCallback? onNegativePressed,
  //       bool isPositiveButtonVisible = true,
  //       bool isNegativeButtonVisible = true,
  //     }) {
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false, // Prevent dismissal on outside tap
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: title != null ? Center(child: Text(title)) : null, // Show title only if not null
  //         content: message != null && message.isNotEmpty ? Text(message) : null, // Show message only if not null and not empty
  //         actions: [
  //           Center(
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 if (isNegativeButtonVisible)
  //                   TextButton(
  //                     onPressed: () {
  //                       if (onNegativePressed != null) {
  //                         onNegativePressed();
  //                       }
  //                       Navigator.of(context).pop(); // Close the dialog
  //                     },
  //                     style: TextButton.styleFrom(
  //                       backgroundColor: Colors.black,
  //                       padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
  //                       shape: RoundedRectangleBorder(
  //                         borderRadius: BorderRadius.circular(10),
  //                       ),
  //                     ),
  //                     child: Text(
  //                       negativeButtonLabel,
  //                       style: TextStyle(color: Colors.white),
  //                     ),
  //                   ),
  //                 if (isNegativeButtonVisible && isPositiveButtonVisible)
  //                   SizedBox(width: 15), // Add spacing only if both buttons are visible
  //                 if (isPositiveButtonVisible)
  //                   TextButton(
  //                     onPressed: () {
  //                       if (onPositivePressed != null) {
  //                         onPositivePressed();
  //                       }
  //                       Navigator.of(context).pop(); // Close the dialog
  //                     },
  //                     style: TextButton.styleFrom(
  //                       backgroundColor: Colors.black,
  //                       padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
  //                       shape: RoundedRectangleBorder(
  //                         borderRadius: BorderRadius.circular(10),
  //                       ),
  //                     ),
  //                     child: Text(
  //                       positiveButtonLabel,
  //                       style: TextStyle(color: Colors.white),
  //                     ),
  //                   ),
  //               ],
  //             ),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }


  static Future<void> showAlertDialog(
      BuildContext context, {
        String? message, // Changed to nullable
        String? title = "Alert",   // Changed to nullable
        String positiveButtonLabel = "Okay",
        String negativeButtonLabel = "Cancel",
        VoidCallback? onPositivePressed,
        VoidCallback? onNegativePressed,
        bool isPositiveButtonVisible = true,
        bool isNegativeButtonVisible = true,
      }) {
    return  showDialog<void>(
      context: context,
      barrierDismissible: false, // Prevent dismissal on outside tap
      builder: (BuildContext context) {
        return AlertDialog(
          title: title != null ? Center(child: Text(title)) : null, // Show title only if not null
          content: message != null && message.isNotEmpty ? Text(message) : null, // Show message only if not null and not empty
          actions: [
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (isNegativeButtonVisible)
                    TextButton(
                      onPressed: () {
                        if (onNegativePressed != null) {
                          onNegativePressed();
                        }
                        Navigator.of(context).pop(); // Close the dialog
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        negativeButtonLabel,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  if (isNegativeButtonVisible && isPositiveButtonVisible)
                    SizedBox(width: 15), // Add spacing only if both buttons are visible
                  if (isPositiveButtonVisible)
                    TextButton(
                      onPressed: () {
                        if (onPositivePressed != null) {
                          onPositivePressed();
                        }
                        Get.back();
                      //  Navigator.of(context).pop(); // Close the dialog
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        positiveButtonLabel,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
