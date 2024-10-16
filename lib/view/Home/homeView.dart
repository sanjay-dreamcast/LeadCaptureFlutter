import 'package:camera/camera.dart';
import 'package:cphi/view/customerWidget/boldTextView.dart';
import 'package:cphi/view/customerWidget/regularTextView.dart';
import 'package:cphi/view/customerWidget/semiBoldTextView.dart';
import 'package:cphi/view/localDatabase/LeadsController.dart';
import 'package:cphi/view/localDatabase/localDataModel.dart';
import 'package:csv/csv.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import '../../api_repository/api_service.dart';
import '../../theme/app_colors.dart';
import '../../utils/UniversalAlertDialog.dart';
import '../Dashboard/dashBoardController.dart';
import '../customerWidget/toolbarTitle.dart';
import '../localDatabase/EventsController.dart';
import '../localDatabase/event_data_Model.dart';
import '../localDatabase/localContactController.dart';
import '../qrCode/view/qr_profile_page.dart';
import 'dart:io' show Directory, File, Platform;

class HomePgae extends GetView<LocalContactController> {
  final EventData? eventData;
  HomePgae({Key? key, this.eventData}) : super(key: key);

  static const routeName = "/LocalContactViewPage";
  final LeadsController leadsController =
      Get.put(LeadsController(Get.find<ApiService>()));
  final EventsController eventsController = Get.put(EventsController(
      Get.find<ApiService>())); // Initialize the EventsController
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
      body: Container(
        color: Colors.white,
        child: GetX<LocalContactController>(builder: (_) {
          return Stack(
            alignment: Alignment.center,
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(
                          top: 24.0), // Adjust padding as needed
                      child: Text(
                        "Event Name",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: grey20Color,
                          fontFamily:
                              'figtree_medium', // Ensure font is included in pubspec.yaml
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(top: 2.0), // Adjust padding as needed
                      child: Obx(() {
                        return Text(
                          "${eventsController.eventData.value.name}", // Update the event data
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontFamily: 'figtree_bold',
                          ),
                        );
                      }),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              print("Stirn");
                              //  var result = await Get.toNamed(QRScanner.routeName);
                              // Get.put(NewQrScan());
                              //  var result = await dashboardController.scanQR();

                              if (eventsController.eventData.value.isSync ==
                                  0) {
                                UniversalAlertDialog.showAlertDialog(
                                  context,
                                  title: "Alert",
                                  message:
                                      "You are not allow to add lead for this event, please contact to administration",
                                  positiveButtonLabel: "OK",
                                  isNegativeButtonVisible: false,
                                );
                                return;
                              }

                              var result =
                                  await Get.toNamed(QrProfilePage.routeName);

                              if (result
                                  .toString()
                                  .toLowerCase()
                                  .contains("begin")) {
                                // Extracting the UC value
                                String? ucValue =
                                    extractUCValue(result.toString());
                                String? nameValue = extractNameValue(
                                    result.toString().replaceAll(";", ""));
                                String? emailValue =
                                    extractEmailValue(result.toString());
                                String? telValue =
                                    extractMobileValue(result.toString());

                                print(nameValue?.replaceAll(";", ""));
                                print(emailValue);
                                print(telValue);

                                if (ucValue != null) {
                                  checkQrCode(
                                      context,
                                      eventsController.eventData.value,
                                      ucValue,
                                      nameValue ?? "",
                                      emailValue ?? "",
                                      telValue ?? "",
                                      true);
                                } else {
                                  UniversalAlertDialog.showAlertDialog(context,
                                          title: "Success!",
                                          message:
                                              "Unique code not found. A valid unique code is necessary to add a lead",
                                          isNegativeButtonVisible: false,
                                          positiveButtonLabel: "Ok")
                                      .then((_) {
                                    // Reset the flag when the dialog is dismissed
                                  });
                                }
                              } else {
                                checkQrCode(
                                    context,
                                    eventsController.eventData.value,
                                    result,
                                    "",
                                    "",
                                    "",
                                    false);
                              }

                              /*if (result["uc"] == null) {
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
                            }*/
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
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(75)),
                                      border: Border.all(
                                          color: primaryColor, width: 2)),
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
                                        textSize: 20,
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
                          const Text(
                            "Tap the QR button to",
                            style: const TextStyle(
                              fontSize: 18,
                              color: blueGrey20,
                              fontFamily: 'figtree_regular',
                            ),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          const Text(
                            "start scanning",
                            style: const TextStyle(
                              fontSize: 18,
                              color: blueGrey20,
                              fontFamily: 'figtree_regular',
                            ),
                          ),
                          // LeadCollectedWidget(),
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
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(40)),
                                        border: Border.all(
                                            color: Colors.transparent)),
                                    width: 250,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          child: Text(
                                            "${controller.localDataList.length} Leads collected",
                                            style: const TextStyle(
                                              fontSize: 24,
                                              color: blueGrey20,
                                            ),
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
                ),
              ),
              controller.loading.value
                  ? Center(child: const CircularProgressIndicator())
                  : const SizedBox()
            ],
          );
        }),
      ),
    );
  }

  String? extractUCValue(String vCardData) {
    // Split the vCard data into lines
    List<String> lines = vCardData.split('\n');

    // Iterate through each line to find the one that contains "UC:"
    for (String line in lines) {
      if (line.trim().startsWith('UC:')) {
        // Extract and return the value after "UC:"
        return line.split(':')[1].trim();
      }
    }
    // Return null if UC value is not found
    return null;
  }

  String? extractNameValue(String vCardData) {
    // Split the vCard data into lines
    List<String> lines = vCardData.split('\n');

    // Iterate through each line to find the one that contains "UC:"
    for (String line in lines) {
      if (line.trim().startsWith('N:')) {
        // Extract and return the value after "UC:"
        return line.split(':')[1].trim();
      }
    }
    // Return null if UC value is not found
    return null;
  }

  String? extractEmailValue(String vCardData) {
    // Split the vCard data into lines
    List<String> lines = vCardData.split('\n');

    // Iterate through each line to find the one that contains "UC:"
    for (String line in lines) {
      if (line.trim().startsWith('EMAIL:')) {
        // Extract and return the value after "UC:"
        return line.split(':')[1].trim();
      }
    }
    // Return null if UC value is not found
    return null;
  }

  String? extractMobileValue(String vCardData) {
    // Split the vCard data into lines
    List<String> lines = vCardData.split('\n');

    // Iterate through each line to find the one that contains "UC:"
    for (String line in lines) {
      if (line.trim().startsWith('TEL:')) {
        // Extract and return the value after "UC:"
        return line.split(':')[1].trim();
      }
    }
    // Return null if UC value is not found
    return null;
  }

  Future<void> checkQrCode(
      BuildContext context,
      EventData? eventData,
      String? qrCodeScanned,
      String name,
      String email,
      String phone,
      bool showBox) async {
    final deviceId = await  getDeviceIdentifier();
    // Ensure both `prefix` and `qrCodeScanned` are not null or empty
    print("qrCodeScanned: $qrCodeScanned, prefix: ${eventData?.prefix}");
    String? qrCodePrefix = eventData?.prefix;
    if (qrCodeScanned != null &&
        qrCodeScanned.isNotEmpty &&
        qrCodePrefix != null &&
        qrCodePrefix.isNotEmpty) {
      // Check if the scanned QR code starts with the given prefix && where the QR code is valid
      if (qrCodeScanned.startsWith(qrCodePrefix)) {
        // The QR code matches the prefix
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AddLeadsDialog(
              onConfirm: (String notes) async {
                controller.loading.value = true;
                await leadsController.addLeads({
                  "event_id": eventData?.id,
                  "qrcode": qrCodeScanned,
                  "device_id": deviceId,
                  "note": notes,
                }, Get.context!);
                controller.loading.value = false;
              },
              name: name,
              email: email,
              phone: phone,
              showUserBox: showBox,
            );
          },
        );
      } else {
        // The QR code does not match the prefix
        print("The QR code does not match the prefix.");

        // Replace with localized strings if necessary
        String title = "Invalid QR Code for Event";
        String message =
            "This code does not belong to the current event. Please use a valid QR code for this event.";
        String buttonText = "Try Again";

        // Show the alert dialog
        UniversalAlertDialog.showAlertDialog(
          context,
          title: title,
          message: message,
          positiveButtonLabel: buttonText,
          isNegativeButtonVisible: false,
        ).then((_) {
          // Handle post-dialog behavior here, if needed
          // e.g., reset input or navigate to a different screen
        });
      }
    } else {
      if (qrCodeScanned != null &&
          qrCodeScanned.isNotEmpty) {
        showDialog(
          context: context,
          builder: (BuildContext context2) {
            return AddLeadsDialog(
              onConfirm: (String notes) {
                controller.loading.value = true;
                leadsController.addLeads({
                  "event_id": eventData?.id,
                  "qrcode": qrCodeScanned,
                  "note": notes,
                  "device_id": deviceId
                }, context);
                controller.loading.value = false;
              },
              name: name,
              email: email,
              phone: phone,
              showUserBox: showBox,
            );
          },
        );
      }
    }
  }

  Future<String?> getDeviceIdentifier() async {
    String? deviceIdentifier = "unknown";
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceIdentifier = androidInfo.id;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceIdentifier = iosInfo.identifierForVendor;
    } else if (kIsWeb) {
      // The web doesnt have a device UID, so use a combination fingerprint as an example
      WebBrowserInfo webInfo = await deviceInfo.webBrowserInfo;
      deviceIdentifier = webInfo.vendor! +
          webInfo.userAgent! +
          webInfo.hardwareConcurrency.toString();
    } else if (Platform.isLinux) {
      LinuxDeviceInfo linuxInfo = await deviceInfo.linuxInfo;
      deviceIdentifier = linuxInfo.machineId;
    }
    print("id=====${deviceIdentifier}");
    return deviceIdentifier;
  }
}

class LeadCollectedWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle tap event here
      },
      child: Container(
        margin: const EdgeInsets.only(top: 36.0),
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
        decoration: BoxDecoration(
          color: white20color, // Set the background color to red
          borderRadius: BorderRadius.circular(40.0), // Round corners
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min, // Wrap width based on content
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Leads Collected', // Use a localization method for strings
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily:
                    'figtree_regular', // Ensure font is included in pubspec.yaml
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
                color:
                    blueGrey20, // Set text color to white for better contrast
              ),
            ),
            SizedBox(
                width: 15.0), // Optional: Add spacing between text and icon
            Icon(
              Icons
                  .arrow_forward_ios, // Replace with your custom icon if needed
              color: blackGrey,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }
}
