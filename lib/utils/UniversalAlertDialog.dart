import 'package:cphi/theme/app_colors.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UniversalAlertDialog {

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
          title: title != null ? Center(child: Text(title,style:
          TextStyle(fontSize: 16,fontWeight: FontWeight.bold,fontFamily: 'figtree_semibold',
          ),)) : null, // Show title only if not null
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
                        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
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
                        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
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

  static Future<void> addLeads(
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
          title:  Row(
            children: [

              // Title text
              Center(
                child: Text(
                  "Add Lead",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'figtree_bold',
                  ),
                ),
              ),
              // Another spacer to keep the right side clean
              Spacer(),
              // Close button on the left
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),

            ],
          ),
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
                        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
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
                        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
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



class CustomDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onConfirm;

  const CustomDialog({
    Key? key,
    required this.title,
    required this.content,
    required this.onConfirm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(5),
      backgroundColor: Colors.transparent, // Make the dialog background transparent
      child: Container(
        width: double.infinity, // Full width with 15 margin on each side
        margin: const EdgeInsets.symmetric(horizontal: 15.0), // Margin of 15
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: Colors.white,
        ),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,

          children: <Widget>[
            const Center(
              child: Text(
                "Add Lead",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'figtree_bold',
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Enter note",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'figtree_bold',
                ),
              ),
            ),
            const SizedBox(height: 10),
            const TextField(
              maxLines: 5, // Allow up to 5 lines
              decoration: InputDecoration(
                hintText: "Note",
                border: OutlineInputBorder(),
                hintStyle: TextStyle(color: Color(0xFF8A8A8E),
                  fontSize: 17,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black,width: 0.8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black,width: 1),
                  // borderRadius: BorderRadius.circular(widget.builder.borderRadius), // Match the corner radius
                ),
              ),
              style: TextStyle(
                fontSize: 17,
                color: Colors.black,
                fontFamily: 'YourFontFamily',
              ),
            ),
            const SizedBox(height: 15),
            Container(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  // Navigator.of(context).pop(); // Close the dialog
                },
                style: TextButton.styleFrom(
                  backgroundColor: blackGrey,
                  padding: EdgeInsets.symmetric(vertical: 5), // You can adjust vertical padding as needed
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  "Add Lead",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
