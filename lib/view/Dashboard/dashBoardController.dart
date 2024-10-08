import 'package:camera/camera.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../../core/vcard_parser.dart';

class DashboardController extends GetxController {
  var tabIndex = 0;
  var loading = false.obs;
  CameraController? _controller;
  Future<void>? _controllerInitialized;
  void changeTabIndex(int index) {
    tabIndex = index;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    _initializeCamera();
  }
  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    _controller = CameraController(
      firstCamera,
      ResolutionPreset.medium,
    );
    await _controller!.initialize();
  }
  Future<Map<String, dynamic>?> scanQR() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
        "#004297",
        "",
        false,
        ScanMode.QR,
      );

      print("@@qrCode $qrCode");

      if (qrCode.toString().length > 20) {
        return Future.delayed(const Duration(microseconds: 0), () {
          Map<String, dynamic> vCardData =
          VcardParser(_textSelect(qrCode.toString().toLowerCase()))
              .parse();
          print(vCardData);
          return vCardData;
        });
      } else {
        // Return null or handle the case where qrCode length is not greater than 20
        return null;
      }
    } catch (e) {
      print("Error while scanning QR code: $e");
      // Return null or handle the error case
      return null;
    }
  }

  String _textSelect(String str) {
    str = str.replaceAll(';', '');
    str = str.replaceAll('type', '');
    str = str.replaceAll('adr', '');
    str = str.replaceAll('pref', '');
    str = str.replaceAll('=', '');
    str = str.replaceAll(',', '');
    str = str.replaceAll('work', '');
    str = str.replaceAll('TELTYPE', '');
    return str;
  }
}
