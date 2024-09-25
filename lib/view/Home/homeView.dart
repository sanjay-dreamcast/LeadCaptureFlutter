import 'package:camera/camera.dart';
import 'package:cphi/view/customerWidget/boldTextView.dart';
import 'package:cphi/view/customerWidget/regularTextView.dart';
import 'package:cphi/view/customerWidget/semiBoldTextView.dart';
import 'package:cphi/view/localDatabase/localDataModel.dart';
import 'package:csv/csv.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import '../../theme/app_colors.dart';
import '../Dashboard/dashBoardController.dart';
import '../customerWidget/toolbarTitle.dart';
import '../localDatabase/localContactController.dart';
import '../qrCode/view/qr_profile_page.dart';
import 'package:flutter/widgets.dart';

class HomePgae extends GetView<LocalContactController> {
  HomePgae({Key? key}) : super(key: key);

  static const routeName = "/LocalContactViewPage";
  @override
  final controller = Get.put(LocalContactController());
  final DashboardController dashboardController = Get.find();
  final textController = TextEditingController().obs;
  final vcardData = 'BEGIN:VCARD\n'
      'VERSION:3.0\n'
      'N:Vishal kumar kumar kumar Sharma\n'
      'TEL:+91 9602193893\n'
      'EMAIL:vishal.sharma.kumar.doe@example.com\n'
      'ORG:Dreamcast Digital Private Limited Jaipur Rajasthan, India\n'
      'TITLE:IOS Developer at Dreamcast digital private limited\n'
      'URL:www.linkedin.com/in/nitishmehta08linkedinlinkedin\n'
      'UC:SBA24DSF6AME\n'
      'END:VCARD';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 0,
          centerTitle: false,
          title: const ToolbarTitle(
            title: "My Contact",
            color: Colors.black,
          ),
          shape:
              const Border(bottom: BorderSide(color: indicatorColor, width: 0)),
          elevation: 0,
          backgroundColor: appBarColor,
          iconTheme: const IconThemeData(color: appIconColor)),
      body: GetX<LocalContactController>(builder: (context) {
        return Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // QrImageView(
                  //   data: vcardData,
                  //   version: QrVersions.auto,
                  //   size: 100.0,
                  // ),
                  GestureDetector(
                    onTap: () async {
                      print("Stirn");
                      //  var result = await Get.toNamed(QRScanner.routeName);
                      // Get.put(NewQrScan());
                      //  var result = await dashboardController.scanQR();
                      var result = await Get.toNamed(QrProfilePage.routeName);
                      print("result=======");
                      print(result);
                      if (result["uc"] == null) {
                        Get.snackbar(
                          snackPosition: SnackPosition.BOTTOM,
                          "Error",
                          "Invalid Contact Card",
                          colorText: Colors.black,
                        );
                        return;
                      }
                      try {
                        dashboardController.changeTabIndex(1);
                        controller.inserUser(
                            LocalUser(
                                id: result!["uc"] ?? "",
                                name: result!["n"] ?? "",
                                email: result!["email"] ?? "",
                                mobile: result!["tel"] ?? "",
                                company: result!["org"] ?? "",
                                title: result!["title"] ?? "",
                                website: result!["url"] ?? ""),
                            null);
                      } catch (e) {
                        print("Error while processing QR code data: $e");
                      }
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Center(
                          child: Image.asset(
                            "assets/images/home_circle.png",
                            height: 180,
                            width: 180,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: const Color(0xffF4F3F7),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(75)),
                              border: Border.all(color: primaryColor)),
                          height: 150,
                          width: 150,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/icons/scan_icon.png",
                                height: 35,
                                width: 35,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const SemiBoldTextView(
                                text: "Add Leads",
                                textSize: 22,
                                color: primaryColor,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const RegularTextView(
                    text: "Tap the QR button to",
                    maxLine: 4,
                    textSize: 18,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const RegularTextView(
                    text: "start scanning",
                    maxLine: 4,
                    textSize: 18,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      // Get.to(LinkedinLoginPage());
                      dashboardController.changeTabIndex(1);
                    },
                    child: controller.localDataList.isEmpty
                        ? const SizedBox()
                        : Container(
                            decoration: BoxDecoration(
                                color: const Color(0xffF4F3F7),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(40)),
                                border: Border.all(color: Colors.transparent)),
                            width: 250,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  child: BoldTextView(
                                    text:
                                        "${controller.localDataList.length} Leads collected",
                                    textSize: 24,
                                    textAlign: TextAlign.start,
                                    color: Color(0xff333333),
                                  ),
                                ),
                                const Icon(CupertinoIcons.forward)
                              ],
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
