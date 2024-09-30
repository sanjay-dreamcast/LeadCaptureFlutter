



import 'package:get/get.dart';

class EmailController extends GetxController {
  var email = ''.obs; // Observable email variable
  var errorMessage = ''.obs; // Observable error message

  void validateEmail() {
    if (email.value.isEmpty) {
      errorMessage.value = 'Please enter email';
    } else if (!_isValidEmail(email.value)) {
      errorMessage.value = 'Please enter a valid email';
    } else {
      errorMessage.value = ''; // No error
    }
  }

  bool _isValidEmail(String email) {
    final RegExp emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }
}
