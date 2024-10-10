import 'package:cphi/theme/app_colors.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme/app_theme.dart';

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
          title: title != null ? Center(child: Text(title,textAlign: TextAlign.center,style:
          TextStyle(fontSize: 16,fontWeight: FontWeight.bold,fontFamily: 'figtree_semibold',
          ),)) : null, // Show title only if not null
          content: message != null && message.isNotEmpty ? Text(message,textAlign: TextAlign.center,) : null, // Show message only if not null and not empty
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
                        backgroundColor: blackGrey,
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
                        backgroundColor: blackGrey,
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



class AddLeadsDialog extends StatelessWidget {

  final Function(String note) onConfirm; // Correctly define the type of onConfirm
  final String name;
  final String email;
  final String phone;
  final bool showUserBox;

  const AddLeadsDialog({
    Key? key,
    required this.onConfirm,
     required this.name,
    required this.email,
    required this.phone,
    required this.showUserBox,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController noteController = TextEditingController();

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
        padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                padding: EdgeInsets.zero, // Remove all padding
                constraints: const BoxConstraints(), // make box constraints empty
                style: const ButtonStyle(tapTargetSize: MaterialTapTargetSize.shrinkWrap), // And this
                icon: Icon(Icons.close), // Close button icon
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
            ),
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
            const SizedBox(height: 20),
           showUserBox ? Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: AppBorderRadius.small,
              ),
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  name.isEmpty ? const SizedBox() :   Padding(
                    padding: const EdgeInsets.only(bottom: 3.0),
                    child: Text(
                       "Name: $name" ,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  phone.isEmpty ? const SizedBox() :   Padding(
                    padding: const EdgeInsets.only(bottom: 3.0),
                    child: Text(
                      "Mobile No: $phone",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  email.isEmpty ? const SizedBox() : Text(
                    "Email: $email",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ) : SizedBox(),
            const SizedBox(height: 20),
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
             TextField(
              controller: noteController,
              maxLines: 5, // Allow up to 5 lines
              decoration: const InputDecoration(
                hintText: "Note",
                border: OutlineInputBorder(),
                hintStyle: TextStyle(color: Color(0xFF8A8A8E),
                  fontSize: 16,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black,width: 0.8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black,width: 1),
                  // borderRadius: BorderRadius.circular(widget.builder.borderRadius), // Match the corner radius
                ),
              ),
              style: const TextStyle(
                fontSize: 17,
                color: Colors.black,
                fontFamily: 'YourFontFamily',
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  onConfirm(noteController.text); // Pass the text to the callback
                  Navigator.of(context).pop(); // Close the dialog
                },
                style: TextButton.styleFrom(
                  backgroundColor: blackGrey,
                  padding: const EdgeInsets.symmetric(vertical: 15), // You can adjust vertical padding as needed
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Add Lead",
                  style: TextStyle(color: Colors.white,fontSize: 18),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
