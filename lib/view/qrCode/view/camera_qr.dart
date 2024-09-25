import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../core/vcard_parser.dart';

class QRScanner extends StatefulWidget {
  static const routeName = "/NewQrScanMain";
  const QRScanner({Key? key}) : super(key: key);
  @override
  _QRScannerState createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  CameraController? _controller;
  Future<void>? _controllerInitialized;
  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    _controller = CameraController(
      firstCamera,
      ResolutionPreset.ultraHigh,
    );

    await _controller!.initialize();

    if (mounted) {
      setState(() {
        _scanQR();
      });
    }
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
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

  Future<void> _scanQR() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
        "#004297",
        "",
        false,
        ScanMode.QR,
      );

      if (mounted) {
        print("Scanned QR code: $qrCode");

        if (qrCode.toString().length > 20) {
          Future.delayed(const Duration(milliseconds: 1000), () {
            Map<String, dynamic> vCardData =
                VcardParser(_textSelect(qrCode.toString().toLowerCase()))
                    .parse();
            //print(vCardData);
            Get.back(result: vCardData);
            //    Navigator.of(context).pop();
          });

          // qrPageController.vCard.value.email =
          //     vCardData["email"].toString().replaceAll(",", "");
          // qrPageController.vCard.value.mobile =
          //     vCardData["mobile"].toString().replaceAll(",", "");
          // qrPageController.vCard.value.uniqueCode =
          //     vCardData["uc"].toString().replaceAll(",", "");
          // qrPageController.vCard.value.uniqueCode =
          //     vCardData["uc"].toString().replaceAll(",", "");
          //getUserDetail(vCardData["uc"].toString().replaceAll(",", ""));
        } else {
          // getUserDetail(scanData.code.toString());
        }
      } else {
        // UiHelper.showSuccessMsg(context, "NO Data found");
      }

      // fast
    } catch (e) {
      print("Error while scanning QR code: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Handle back button press
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('QR Scanner'),
        ),
        body: FutureBuilder<void>(
          future: _controllerInitialized,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // Camera initialization is complete, show CameraPreview with adjusted AspectRatio
              return Stack(
                children: [
                  Container(
                    child: Container(
                      color: Colors.transparent,
                      child: AspectRatio(
                        aspectRatio: _controller!.value.aspectRatio,
                        child: CameraPreview(_controller!),
                      ),
                    ),
                  )
                  // Overlay views
                ],
              );
            } else {
              // Camera is still initializing, show a loading indicator
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
