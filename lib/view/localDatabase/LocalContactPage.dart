import 'package:contacts_service/contacts_service.dart';
import 'package:cphi/model/Status.dart';
import 'package:cphi/view/Dashboard/dashBoardController.dart';
import 'package:cphi/view/customerWidget/boldTextView.dart';
import 'package:cphi/view/customerWidget/regularTextView.dart';
import 'package:cphi/view/customerWidget/semiBoldTextView.dart';
import 'package:cphi/view/localDatabase/addContactPage.dart';
import 'package:cphi/view/localDatabase/contactDetailModel.dart';
import 'package:cphi/view/localDatabase/localDataModel.dart';
import 'package:cphi/view/qrCode/view/camera_qr.dart';
import 'package:csv/csv.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:vcard_maintained/vcard_maintained.dart';
import '../../api_repository/api_service.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_theme.dart';
import '../../utils/UniversalAlertDialog.dart';
import '../customerWidget/customSearchView.dart';
import '../customerWidget/customTextView.dart';
import '../customerWidget/search_bar_widget.dart';
import '../customerWidget/toolbarTitle.dart';
import '../qrCode/view/qr_profile_page.dart';
import 'EventsController.dart';
import 'LeadsController.dart';
import 'contactDetailPage.dart';
import 'event_data_Model.dart';
import 'localContactController.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'dart:io' show Directory, File, Platform;

class LocalContactViewPage extends GetView<LocalContactController> {
  LocalContactViewPage({Key? key}) : super(key: key);
  final LeadsController leadsController =
      Get.put(LeadsController(Get.find<ApiService>()));

  final EventsController eventsController =
      Get.put(EventsController(Get.find<ApiService>()));

  static const routeName = "/LocalContactViewPage";
  @override
  final controller = Get.put(LocalContactController());
  final textController = TextEditingController().obs;
  DashboardController dashboardController = Get.find();
  ScrollController _scrollController = ScrollController();
  var isOpen = false;

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
        iconTheme: const IconThemeData(color: appIconColor),
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.white,
            child: Obx(() {
              switch (leadsController.leadBodyData.value.status) {
                case Status.loading:
                  return const Center(child: CircularProgressIndicator());
                case Status.error:
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Center(
                      child: Text(
                        leadsController.leadBodyData.value.message ??
                            "No leads found",
                        style: const TextStyle(
                            color: blackGrey,
                            fontSize: 20,
                            fontFamily: "figtree_semibold"),
                      ),
                    ),
                  );
                case Status.success:
                  return Stack(
                    children: [
                      Container(
                        color: white,
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, top: 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    child: Text(
                                        "Total ${leadsController.leads?.length} Leads",
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: "figtree_semibold",
                                            color: blackGrey)),
                                  ),
                                  /*
                                  //EXPORT
                                  GestureDetector(
                                    onTap: _generateCsvFile,
                                    child: Container(
                                      width: 120,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(20)),
                                          border: Border.all(color: Colors.black)),
                                      padding: EdgeInsets.all(10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Image.asset("assets/icons/export.png",
                                              height: 15, width: 15),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          const BoldTextView(
                                            text: "Export",
                                            textSize: 16,
                                            textAlign: TextAlign.start,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  */
                                ],
                              ),
                            ),
                            SearchBarWidget(
                              onSearch: (query) {
                                leadsController.filterEvents(query);
                              },
                            ),
                            const SizedBox(
                              height: 1,
                            ),
                            SlidableAutoCloseBehavior(
                              child: Expanded(
                                child: ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  controller: _scrollController,
                                  scrollDirection: Axis.vertical,
                                  itemCount: leadsController.leads?.length,
                                  itemBuilder: (context, index) {
                                    var data = leadsController.leads?[index];
                                    return GestureDetector(
                                      onTap: () async {
                                        // if (await controller.checkNetwork()) {
                                        // controller.getContactDetailApi(
                                        //     {"code": data?.id ?? ""}, context);
                                        // } else {
                                        var localDetail = Data(
                                            id: data?.id ?? "",
                                            name: data?.name ?? "",
                                            shortName:
                                                getShortName(data?.name ?? "")
                                                    .toUpperCase(),
                                            avatar: "",
                                            company: data?.company ?? "",
                                            countryCode: "",
                                            description: "",
                                            email: data?.email ?? "",
                                            mobile: data?.mobile ?? "",
                                            position: data?.position ?? "",
                                            website: data?.website ?? "",
                                            note: data?.note ?? "");
                                        controller.contactDetail.value.data =
                                            localDetail;
                                        Get.toNamed(
                                            ContactDetailPage.routeName);

                                        // ScaffoldMessenger.of(context).showSnackBar(
                                        //     const SnackBar(
                                        //         content: Text(
                                        //             "No Internet connection")));
                                        //  }
                                      },
                                      child: StatefulBuilder(
                                          builder: (context, setState) {
                                        return Container(
                                          color: indicatorColor,
                                          child: Slidable(
                                            key: const ValueKey(1),
                                            closeOnScroll: true,
                                            endActionPane: ActionPane(
                                              dragDismissible: false,
                                              motion: const ScrollMotion(),
                                              children: [
                                                const SizedBox(
                                                  width: 15,
                                                ),
                                                //   SlidableAutoCloseBehavior(
                                                //     closeWhenTapped: true,
                                                //     closeWhenOpened: true,
                                                //     child: InkWell(
                                                //       /*
                                                // onTap: () async {
                                                //   ///Create a new vCard
                                                //   var vCard = VCard();
                                                //
                                                //   ///Set properties
                                                //   vCard.firstName =
                                                //       data?.name.capitalize ??
                                                //           "";
                                                //   vCard.middleName = '';
                                                //   vCard.lastName = "";
                                                //   vCard.email =
                                                //       data?.email ?? "";
                                                //   vCard.workPhone =
                                                //       data?.mobile ?? "";
                                                //   vCard.organization = data
                                                //           ?.company
                                                //           .capitalize ??
                                                //       "";
                                                //   vCard.jobTitle =
                                                //       data?.title.capitalize ??
                                                //           "";
                                                //   vCard.note = '';
                                                //   shareAllVCFCard(context,
                                                //       vCard: [vCard]);
                                                //   setState(() {});
                                                // },
                                                // */
                                                //       child: Card(
                                                //         shape: RoundedRectangleBorder(
                                                //             borderRadius:
                                                //             BorderRadius
                                                //                 .circular(
                                                //                 10)),
                                                //         child: Container(
                                                //           margin:
                                                //           const EdgeInsets
                                                //               .all(3),
                                                //           padding:
                                                //           const EdgeInsets
                                                //               .all(10),
                                                //           height: 40,
                                                //           width: 40,
                                                //           child: Image.asset(
                                                //               "assets/icons/share.png"),
                                                //         ),
                                                //       ),
                                                //     ),
                                                //   ),
                                                GestureDetector(
                                                  onTap: () {
                                                    showAlertDialog(context,
                                                        data?.id ?? "", index);
                                                  },
                                                  child: Card(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                    child: Container(
                                                      margin:
                                                          const EdgeInsets.all(
                                                              3),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10),
                                                      height: 40,
                                                      width: 40,
                                                      child: Image.asset(
                                                          "assets/icons/delete.png"),
                                                    ),
                                                  ),
                                                ),
                                                //     InkWell(
                                                //       /*
                                                //   onTap: () async {
                                                //   var contact = Contact(
                                                //       displayName:
                                                //           data?.name.capitalize ??
                                                //               "",
                                                //       familyName: "",
                                                //       company: data?.company
                                                //               .capitalize ??
                                                //           "",
                                                //       jobTitle: data?.title
                                                //               .capitalize ??
                                                //           "",
                                                //       emails: [
                                                //         Item(
                                                //             label: "email",
                                                //             value:
                                                //                 data?.email ?? "")
                                                //       ],
                                                //       phones: [
                                                //         Item(
                                                //             label: "mobile",
                                                //             value: data?.mobile ??
                                                //                 "")
                                                //       ]);
                                                //
                                                //   //  ContactsService.addContact(contact);
                                                //
                                                //   var result =
                                                //       await Get.to(AddContactView(
                                                //     contact: contact,
                                                //   ));
                                                //   if (result == "true") {
                                                //     ScaffoldMessenger.of(context)
                                                //         .showSnackBar(const SnackBar(
                                                //             content: Text(
                                                //                 "Contact saved")));
                                                //   }
                                                //
                                                //   // if (await ContactsService
                                                //   //     .requestPermission()) {
                                                //   //   final newContact = Contact()
                                                //   //     ..name.first = data?.name ?? ""
                                                //   //     ..displayName = data?.name ?? ""
                                                //   //     ..phones = [
                                                //   //       Phone(data?.mobile ?? "")
                                                //   //     ]
                                                //   //     ..emails = [
                                                //   //       Email(data?.email ?? "")
                                                //   //     ]
                                                //   //     ..organizations = [
                                                //   //       Organization(
                                                //   //           company:
                                                //   //               data?.company ?? "",
                                                //   //           title: data?.title ?? "")
                                                //   //     ];
                                                //   //   await newContact.insert();
                                                //   //   ScaffoldMessenger.of(context)
                                                //   //       .showSnackBar(const SnackBar(
                                                //   //           content:
                                                //   //               Text("Contact saved")));
                                                //   // }
                                                // },
                                                // */
                                                //       child: Card(
                                                //         shape:
                                                //         RoundedRectangleBorder(
                                                //             borderRadius:
                                                //             BorderRadius
                                                //                 .circular(
                                                //                 10)),
                                                //         child: Container(
                                                //           margin: const EdgeInsets
                                                //               .all(3),
                                                //           padding:
                                                //           const EdgeInsets
                                                //               .all(10),
                                                //           height: 40,
                                                //           width: 40,
                                                //           child: Image.asset(
                                                //               "assets/icons/saveto_phone.png"),
                                                //         ),
                                                //       ),
                                                //     )
                                              ],
                                            ),
                                            child: Container(
                                              color: white,
                                              padding: const EdgeInsets.all(10),
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: const Color(
                                                            0xffE8E8E8),
                                                        width: 1),
                                                    borderRadius:
                                                        AppBorderRadius.medium),
                                                child: ListTile(
                                                  contentPadding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                          vertical: 0,
                                                          horizontal: 10),
                                                  leading: circularImage(
                                                      url: "",
                                                      shortName: getShortName(
                                                              data?.name ?? "")
                                                          .toUpperCase()),
                                                  title: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SemiBoldTextView(
                                                        text: data?.name
                                                                ?.capitalize ??
                                                            "",
                                                        textAlign:
                                                            TextAlign.start,
                                                        maxLines: 3,
                                                        textSize: 18,
                                                      ),
                                                      RegularTextView(
                                                        text: data?.company
                                                                ?.capitalize ??
                                                            "",
                                                        textAlign:
                                                            TextAlign.start,
                                                        maxLine: 3,
                                                      ),
                                                    ],
                                                  ),
                                                  trailing: const Icon(
                                                    CupertinoIcons.forward,
                                                    color: black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // controller.loading.value
                      controller.loading.value
                          ? const Center(child: CircularProgressIndicator())
                          : leadsController.leadBodyData.value.data?.leads
                                      ?.isEmpty ??
                                  true
                              ? const Center(
                                  child: BoldTextView(
                                  text: "No leads found",
                                ))
                              : SizedBox()
                    ],
                  ); // Ensure this method returns a Widget.
                default:
                  return const Center(child: Text("No leads found"));
              }
            }),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: GestureDetector(
        onTap: () async {
          if (eventsController.eventData.value.isSync == 0) {
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

          // var result = await dashboardController.scanQR();
          //var result = await Get.toNamed(QRScanner.routeName);
          //  var result = await Get.toNamed(QrProfilePage.routeName);
          // print("result=======");
          // print(result);
          var result = await Get.toNamed(QrProfilePage.routeName);
          if (result.toString().toLowerCase().contains("begin")) {
            // Extracting the UC value
            String? ucValue = extractUCValue(result.toString());

            // Extracting the UC value
            String? nameValue = extractNameValue(result.toString().replaceAll(";", ""));
            String? emailValue = extractEmailValue(result.toString());
            String? telValue = extractMobileValue(result.toString());

            if (ucValue != null) {
              checkQrCode(context,eventsController.eventData.value,ucValue,nameValue ?? "",emailValue ?? "", telValue ??"",true);
              print('UC Value: $ucValue');
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
            checkQrCode(context, eventsController.eventData.value, result,"","","",false);
          }
        },
        child: Container(
          width: 150,
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(15),
          decoration: const BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.all(Radius.circular(50))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/icons/scan_icon.png",
                height: 25,
                width: 25,
                color: white,
              ),
              const SizedBox(
                width: 10,
              ),
              const BoldTextView(
                text: "Add Leads",
                color: white,
                textSize: 16,
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> checkQrCode(BuildContext context, EventData? eventData, String? qrCodeScanned, String name,String email,String phone,bool showBox) async {
    final deviceId = await getDeviceIdentifier();
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
          builder: (BuildContext context2) {
            return AddLeadsDialog(
              onConfirm: (String notes) {
                controller.loading.value = true;
                print("notes-> $notes");
                leadsController.addLeads({
                  "event_id": eventData?.id,
                  "qrcode": qrCodeScanned,
                  "note": notes,
                  "device_id": deviceId
                }, context);
                controller.loading.value = false;
              }, name: name,
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
                print("notes-> $notes");
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

        print("QR code or prefix is empty.");
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

  Widget circularImage({url, shortName}) {
    return SizedBox(
      height: 60,
      width: 60,
      child: url != null && url.toString().isNotEmpty
          ? Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.transparent, width: 0),
                  shape: BoxShape.rectangle,
                  borderRadius: AppBorderRadius.circular()),
              child: CircleAvatar(backgroundImage: NetworkImage(url)),
            ) /*CircleAvatar(backgroundImage: NetworkImage(url))*/
          : Container(
              decoration: BoxDecoration(
                color: indicatorColor,
                borderRadius: AppBorderRadius.circular(),
                border: Border.all(color: Colors.transparent, width: 0),
              ),
              child: Center(
                child: BoldTextView(
                  text: shortName ?? "",
                  textAlign: TextAlign.center,
                  textSize: 20,
                ),
              ),
            ),
    );
  }

  String getShortName(String name) {
    if (name.trim().isEmpty) {
      return ''; // Return an empty string if the input name is empty
    }
    List<String> names = name.trim().split(" ");
    String initials = "";
    // Loop through all words and collect the first character of each
    for (var i = 0; i < names.length; i++) {
      if (names[i].isNotEmpty) {
        initials += names[i][0]
            .toUpperCase(); // Get the first letter, uppercase for better formatting
      }
    }
    return initials;
  }

  void shareAllVCFCard(BuildContext context,
      {required List<VCard> vCard}) async {
    try {
      List<String> vcsCardPath = <String>[];
      for (final card in vCard) {
        var vCardAsString = card.getFormattedString();
        final directory = await getApplicationDocumentsDirectory();
        final path = directory.path;
        var pathAsText = "$path/contact.txt";
        var contactAsFile = File(await getFilePath("contact"));
        await contactAsFile.writeAsString(vCardAsString);

        var vcf = contactAsFile
            .renameSync(contactAsFile.path.replaceAll(".txt", ".vcf"));
        vcsCardPath.add(vcf.path);
      }

      Share.shareFiles(vcsCardPath, text: 'Contact Card');
    } catch (e) {
      print("Error Creating VCF File $e");
      return null;
    }
  }

  Future<String> getFilePath(String fileName) async {
    Directory appDocumentsDirectory =
        await getApplicationDocumentsDirectory(); // 1
    String appDocumentsPath = appDocumentsDirectory.path; // 2
    String filePath = '$appDocumentsPath/$fileName.txt'; // 3
    return filePath;
  }

  showAlertDialog(BuildContext context, String id, int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)), //this right here
            child: SizedBox(
              height: 400,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Stack(
                  children: [
                    Positioned(
                      top: 2,
                      right: 2,
                      child: GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: const Icon(
                          Icons.clear,
                          color: textGrayColor,
                          size: 25,
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: CircleAvatar(
                            radius: 40,
                            backgroundColor: indicatorColor,
                            child: Image.asset(
                              "assets/icons/delete_red.png",
                              height: 35,
                              width: 35,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Center(
                          child: customTextView(
                            text: "Delete Lead ?",
                            textSize: 24,
                            maxLines: 2,
                           weight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Center(
                          child: customTextView(
                            text: "Deleting this lead will permanently remove it from your records. Are you sure you want to continue?",
                            textSize: 18,
                            maxLines: 20,
                            weight: FontWeight.normal,
                          ),
                        ),
                        const Divider(height: 40,thickness: 1,),
                        Center(
                          child: GestureDetector(
                            onTap: () async {
                              if (index == 0 ||
                                  index == 1 ||
                                  index == 2 ||
                                  index == 3) {
                                _scrollController.jumpTo(
                                    _scrollController.position.maxScrollExtent);
                              } else {
                                _scrollController.jumpTo(
                                    _scrollController.position.minScrollExtent);
                              }

                              Get.back();
                              //  controller.deleteOneRecordById(id, index);

                              controller.loading.value = true;

                              await leadsController
                                  .deleteLeads({"id": id}, context, index);
                              print("lead deleted====");
                              controller.loading.value = false;
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                  color: Colors.black,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              height: 50,
                              width: 150,
                              child: const Center(
                                child: BoldTextView(
                                  text: "Yes, Delete",
                                  color: white,
                                  textSize: 16,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  void _generateCsvFile() async {
    controller.loading(true);
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();

    List<List<dynamic>> rows = [];

    List<dynamic> row = [];
    for (var data in controller.headerList) {
      row.add(data);
    }
    rows.add(row);
    for (int i = 0; i < controller.localDataList.length; i++) {
      LocalUser contacts = controller.localDataList[i];
      List<dynamic> row = [];
      row.add(contacts.name.capitalize ?? "");
      row.add(contacts.email ?? "");
      row.add(contacts.mobile ?? "");
      row.add(contacts.company.capitalize ?? "");
      row.add(contacts.title.capitalize ?? "");
      row.add(contacts.website ?? "");
      rows.add(row);
    }

    String csv = const ListToCsvConverter().convert(rows);
    Directory? directory = Platform.isAndroid
        ? await getExternalStorageDirectory() //FOR ANDROID
        : await getApplicationSupportDirectory();

    var timestamps = DateTime.now().minute;
    if (directory?.path != null) {
      File f = File("${directory!.path!}/${timestamps}contact.csv");
      f.writeAsString(csv);
      print(f.path);
      if (f.path != null) {
        try {
          var exception = await OpenFile.open(f.path);
          controller.loading(false);
          if (exception.message == "the file does not exist") {
            _generateCsvFile();
          }
          print('object==========');
          print(exception.message);
        } catch (e) {
          controller.loading(false);
          print('exception-:$e');
        }
      }
    }
  }
}
