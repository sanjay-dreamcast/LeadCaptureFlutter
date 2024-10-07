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
import 'package:flutter/cupertino.dart';
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
import '../customerWidget/customSearchView.dart';
import '../customerWidget/toolbarTitle.dart';
import '../qrCode/view/qr_profile_page.dart';
import 'LeadsController.dart';
import 'contactDetailPage.dart';
import 'localContactController.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'dart:io' show Directory, File, Platform;

class LocalContactViewPage extends GetView<LocalContactController> {
  LocalContactViewPage({Key? key}) : super(key: key);
  final LeadsController leadsController = Get.put(LeadsController(Get.find<ApiService>()));

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
          iconTheme: const IconThemeData(color: appIconColor)),
      body: Container(
        color: Colors.white,
        child: GetX<LocalContactController>(builder: (context) {
          return
            // leadsController.leadBodyData.value.l.isEmpty
            //   ? const Center(
            //       child: BoldTextView(
            //         text: "No leads found",
            //       ),
            //     )
            //   :
          Stack(
                  children: [
                    Container(
                      color: white,
                      padding: const EdgeInsets.only(bottom: 100),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  child: SemiBoldTextView(
                                    text:
                                        "Total ${leadsController.leads?.length} Leads",
                                    textSize: 24,
                                    textAlign: TextAlign.start,
                                  ),
                                ),
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
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                                top: 10, left: 10, right: 10),
                            child: SearchView(
                              title: "Search here",
                              textController: textController,
                              press: () async {
                                // controller.filterSearchResults("");
                                controller.searchContact("");
                              },
                              onSubmit: (result) async {
                                //  controller.filterSearchResults(result);
                                controller.searchContact(result);
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          SlidableAutoCloseBehavior(
                            child: Expanded(
                              child: ListView.builder(
                                controller: _scrollController,
                                scrollDirection: Axis.vertical,
                                itemCount: controller.tempChatList.length,
                                itemBuilder: (context, index) {
                                  var data = controller.tempChatList?[index];
                                  return GestureDetector(
                                    onTap: () async {
                                      // if (await controller.checkNetwork()) {
                                      controller.getContactDetailApi(
                                          {"code": data?.id ?? ""}, context);
                                      // } else {
                                      var localDetail = Data(
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
                                          position: data?.title ?? "",
                                          website: data?.website ?? "");
                                      controller.contactDetail.value.data =
                                          localDetail;
                                      Get.toNamed(ContactDetailPage.routeName);

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
                                          key: const ValueKey(0),
                                          closeOnScroll: true,
                                          endActionPane: ActionPane(
                                            dragDismissible: false,
                                            motion: const ScrollMotion(),
                                            children: [
                                              const SizedBox(
                                                width: 15,
                                              ),
                                              SlidableAutoCloseBehavior(
                                                closeWhenTapped: true,
                                                closeWhenOpened: true,
                                                child: InkWell(
                                                  onTap: () async {
                                                    ///Create a new vCard
                                                    var vCard = VCard();

                                                    ///Set properties
                                                    vCard.firstName =
                                                        data?.name.capitalize ??
                                                            "";
                                                    vCard.middleName = '';
                                                    vCard.lastName = "";
                                                    vCard.email =
                                                        data?.email ?? "";
                                                    vCard.workPhone =
                                                        data?.mobile ?? "";
                                                    vCard.organization = data
                                                            ?.company
                                                            .capitalize ??
                                                        "";
                                                    vCard.jobTitle =
                                                        data?.title.capitalize ??
                                                            "";
                                                    vCard.note = '';
                                                    shareAllVCFCard(context,
                                                        vCard: [vCard]);
                                                    setState(() {});
                                                  },
                                                  child: Card(
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                10)),
                                                    child: Container(
                                                      margin:
                                                          const EdgeInsets.all(3),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10),
                                                      height: 40,
                                                      width: 40,
                                                      child: Image.asset(
                                                          "assets/icons/share.png"),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  showAlertDialog(context,
                                                      data?.id ?? "", index);
                                                },
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Container(
                                                    margin:
                                                        const EdgeInsets.all(3),
                                                    padding:
                                                        const EdgeInsets.all(10),
                                                    height: 40,
                                                    width: 40,
                                                    child: Image.asset(
                                                        "assets/icons/delete.png"),
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () async {
                                                  var contact = Contact(
                                                      displayName:
                                                          data?.name.capitalize ??
                                                              "",
                                                      familyName: "",
                                                      company: data?.company
                                                              .capitalize ??
                                                          "",
                                                      jobTitle: data?.title
                                                              .capitalize ??
                                                          "",
                                                      emails: [
                                                        Item(
                                                            label: "email",
                                                            value:
                                                                data?.email ?? "")
                                                      ],
                                                      phones: [
                                                        Item(
                                                            label: "mobile",
                                                            value: data?.mobile ??
                                                                "")
                                                      ]);

                                                  //  ContactsService.addContact(contact);

                                                  var result =
                                                      await Get.to(AddContactView(
                                                    contact: contact,
                                                  ));
                                                  if (result == "true") {
                                                    ScaffoldMessenger.of(context)
                                                        .showSnackBar(const SnackBar(
                                                            content: Text(
                                                                "Contact saved")));
                                                  }

                                                  // if (await ContactsService
                                                  //     .requestPermission()) {
                                                  //   final newContact = Contact()
                                                  //     ..name.first = data?.name ?? ""
                                                  //     ..displayName = data?.name ?? ""
                                                  //     ..phones = [
                                                  //       Phone(data?.mobile ?? "")
                                                  //     ]
                                                  //     ..emails = [
                                                  //       Email(data?.email ?? "")
                                                  //     ]
                                                  //     ..organizations = [
                                                  //       Organization(
                                                  //           company:
                                                  //               data?.company ?? "",
                                                  //           title: data?.title ?? "")
                                                  //     ];
                                                  //   await newContact.insert();
                                                  //   ScaffoldMessenger.of(context)
                                                  //       .showSnackBar(const SnackBar(
                                                  //           content:
                                                  //               Text("Contact saved")));
                                                  // }
                                                },
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Container(
                                                    margin:
                                                        const EdgeInsets.all(3),
                                                    padding:
                                                        const EdgeInsets.all(10),
                                                    height: 40,
                                                    width: 40,
                                                    child: Image.asset(
                                                        "assets/icons/saveto_phone.png"),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          child: Container(
                                            color: white,
                                            padding: const EdgeInsets.all(10),
                                            child: Container(
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color:
                                                          const Color(0xffE8E8E8),
                                                      width: 1),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(15))),
                                              child: ListTile(
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5),
                                                leading: circularImage(
                                                    url: "",
                                                    shortName: getShortName(
                                                            data?.name ?? "")
                                                        .toUpperCase()),
                                                title: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SemiBoldTextView(
                                                      text:
                                                          data?.name.capitalize ??
                                                              "",
                                                      textAlign: TextAlign.start,
                                                      maxLines: 3,
                                                      textSize: 18,
                                                    ),
                                                    RegularTextView(
                                                      text: data?.company
                                                              .capitalize ??
                                                          "",
                                                      textAlign: TextAlign.start,
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
                    leadsController.leadBodyData.value.status == Status.loading
                        ? const Center(child: CircularProgressIndicator())
                        : SizedBox()
                  ],
                );
        }),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: GestureDetector(
        onTap: () async {
          // var result = await dashboardController.scanQR();
          //var result = await Get.toNamed(QRScanner.routeName);
          var result = await Get.toNamed(QrProfilePage.routeName);
          print("result=======");
          print(result);
          if (result["uc"] == null) {
            ScaffoldMessenger.of(context!)
                .showSnackBar(SnackBar(content: Text("Invalid Vcard")));
            return;
          }
          controller.inserUser(
              LocalUser(
                id: result!["uc"] ?? "",
                name: result!["n"] ?? "",
                email: result!["email"] ?? "",
                mobile: result!["tel"] ?? "",
                company: result!["org"] ?? "",
                title: result!["title"] ?? "",
                website: result!['url'] ?? "",
              ),
              context);
        },
        child: Container(
          width: 150,
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.all(15),
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

  Widget circularImage({url, shortName}) {
    return SizedBox(
      height: 50,
      width: 50,
      child: url != null && url.toString().isNotEmpty
          ? Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.transparent, width: 0),
                shape: BoxShape.rectangle,
                borderRadius: const BorderRadius.all(Radius.circular(25)),
              ),
              child: CircleAvatar(backgroundImage: NetworkImage(url)),
            ) /*CircleAvatar(backgroundImage: NetworkImage(url))*/
          : Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: indicatorColor,
                borderRadius: const BorderRadius.all(Radius.circular(25)),
                border: Border.all(color: Colors.transparent, width: 0),
              ),
              child: Center(
                  child: BoldTextView(
                text: shortName ?? "",
                textAlign: TextAlign.center,
                textSize: 20,
              )),
            ),
    );
  }

  String getShortName(name) {
    List<String> names = name.split(" ");
    String initials = "";
    int numWords = 1;
    if (numWords < names.length) {
      numWords = names.length;
    }
    if (names.length > 1) {
      for (var i = 0; i < numWords; i++) {
        initials += '${names[i][0]}';
      }
      return initials;
    } else {
      return names[0];
    }
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
              height: 330,
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
                          height: 35,
                        ),
                        const Center(
                            child: BoldTextView(
                          text: "Are you sure you want to delete?",
                          textSize: 18,
                          maxLines: 2,
                        )),
                        const SizedBox(
                          height: 35,
                        ),
                        Center(
                          child: GestureDetector(
                            onTap: () {
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

                              controller.deleteOneRecordById(id, index);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("Contact Deleted")));
                              Get.back();
                              Get.back();
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
