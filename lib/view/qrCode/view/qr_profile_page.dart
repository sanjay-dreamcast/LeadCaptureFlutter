import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../../../core/vcard_parser.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/strings.dart';
import '../../customerWidget/toolbarTitle.dart';
import '../controller/qr_page_controller.dart';

class QrProfilePage extends StatefulWidget {
  const QrProfilePage({Key? key}) : super(key: key);
  static const routeName = "/QrScanPage";

  @override
  State<QrProfilePage> createState() => _QrProfilePageState();
}

class _QrProfilePageState extends State<QrProfilePage>
    with SingleTickerProviderStateMixin {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  // final AuthenticationManager controller = Get.find();
  Barcode? result;
  QRViewController? qrViewController;
  final editController = TextEditingController();
  final QrPageController qrPageController = Get.put(QrPageController());
  //final UsersController usersController = Get.put(UsersController());
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      qrViewController?.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              centerTitle: false,
              backgroundColor: appBarColor,
              iconTheme: const IconThemeData(color: appIconColor),
              title: const ToolbarTitle(
                title: MyStrings.qr_scan,
                color: black,
              ),
            ),
            body: _buildQrView(context)
            /* DefaultTabController(
            length: 2,
            child: Scaffold(
              backgroundColor: white,
              appBar: TabBar(
                controller: _tabController,
                labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                labelColor: primaryColor,
                indicatorColor: primaryColor,
                dividerColor: primaryColor,
                unselectedLabelColor: grayColorLight,
                onTap: (int index) {
                  _tabController.index = index;
                  if (index == 0) {
                    Future.delayed(const Duration(seconds: 2), () {
                      qrViewController?.pauseCamera();
                      qrViewController?.stopCamera();
                    });
                  } else {
                    qrViewController?.resumeCamera();
                  }
                },
                tabs: const [
                  Tab(text: MyStrings.my_code),
                  Tab(text: MyStrings.scan),
                ],
              ),
              body: TabBarView(
                controller: _tabController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildMyCode(context),
                  _buildQrView(context),
                ],
              ),
            ),
          ),*/
            ));
  }

  _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 250.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: const Color(0xfff1877f2),
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      qrViewController = controller;
    });
    if (Platform.isAndroid&& qrViewController != null) {
      qrViewController?.resumeCamera();
    }
    controller.scannedDataStream.listen((scanData) async {
      if (scanData.code != null && scanData.code!.isNotEmpty) {
        //qrPageController.vCard.value.uniqueCode=scanData.code.toString();
        /*Future.delayed(const Duration(seconds: 2), () {
          controller.pauseCamera();
        });
        print("scanData.code=======");
        print(scanData.code);
        Get.back(result: scanData.code);*/
        print("code scannedd");
        try {
          await qrViewController?.pauseCamera();
          print(scanData.code);
          // Optional: delay for smooth transition
          await Future.delayed(const Duration(milliseconds: 500));
          Get.back(result: scanData.code);
        } catch (e) {
          // Handle any potential errors here
          print("Error pausing camera or navigating back: $e");
        }
        // comment

       /* if (scanData.code.toString().length > 10) {
          Map<String, dynamic> vCardData =
              VcardParser(_textSelect(scanData.code.toString().toLowerCase()))
                  .parse();
          print("V card data====-=");
          print(vCardData);
          Get.back(result: vCardData);
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
        }*/
      } else {
        // UiHelper.showSuccessMsg(context, "NO Data found");

    }});
  }

  void getUserDetail(String? code) async {
    qrViewController?.pauseCamera();
    await qrPageController.getUserDetail(context, code);
    //qrPageController.vCard.refresh();
    //qrPageController.userFound(true);
    _tabController.index = 0;
    setState(() {});
  }

  String _textSelect(String str) {
    str = str.replaceAll(';', '');
    str = str.replaceAll('type=', '');
    str = str.replaceAll('adr', '');
    str = str.replaceAll('pref', '');
    str = str.replaceAll('=', '');
    str = str.replaceAll(',', '');
    str = str.replaceAll('work', '');
    str = str.replaceAll('TELTYPE', '');
    return str;
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    qrViewController?.stopCamera();
    qrViewController?.dispose();
    print("dispose->");
    super.dispose();
  }
}
