import 'dart:io';

class ConnectivityHelper {
  // Method to check internet connection
  static Future<bool> checkInternetConnection() async {
    try {
      // Attempt to connect to a known server (e.g., Google DNS)
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }
}
