import 'package:cphi/view/customerWidget/boldTextView.dart';
import 'package:cphi/view/customerWidget/regularTextView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:share_plus/share_plus.dart';
import 'package:vcard_maintained/vcard_maintained.dart';
import '../../api_repository/api_service.dart';
import '../../theme/app_colors.dart';
import '../customerWidget/customTextView.dart';
import '../customerWidget/toolbarTitle.dart';
import 'LeadsController.dart';
import 'localContactController.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'dart:io' show Directory, File, Platform;

class ContactDetailPage extends GetView<LocalContactController> {
  dynamic id;
  int index;
  ContactDetailPage({
    Key? key,
    required this.id,
    required this.index,
  }) : super(key: key);

  static const routeName = "/ContactDetailPage";
  @override
  final controller = Get.put(LocalContactController());
  final textController = TextEditingController().obs;
  final LeadsController leadsController =
      Get.put(LeadsController(Get.find<ApiService>()));

  static const List<Tab> myTabs = <Tab>[
    Tab(text: 'Profile'),
    Tab(text: 'Company'),
    Tab(text: 'Note'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const ToolbarTitle(
          title: "Profile",
          color: Colors.black,
        ),
        actions: [
          // InkWell(
          //   splashColor: textGrayColor,
          //   highlightColor: white,
          //   onTap: () {
          //     var vCard = VCard();
          //
          //     ///Set properties
          //     vCard.firstName =
          //         controller.contactDetail.value.data?.name?.capitalize ?? "";
          //     vCard.middleName = '';
          //     vCard.lastName = "";
          //     vCard.email = controller.contactDetail.value.data?.email ?? "";
          //     vCard.workPhone =
          //         controller.contactDetail.value.data?.mobile ?? "";
          //     vCard.organization =
          //         controller.contactDetail.value.data?.company?.capitalize ??
          //             "";
          //     vCard.jobTitle =
          //         controller.contactDetail.value.data?.position?.capitalize ??
          //             "";
          //     vCard.note = '';
          //     shareAllVCFCard(context, vCard: [vCard]);
          //   },
          //   child: const CircleAvatar(
          //     radius: 15,
          //     backgroundColor: indicatorColor,
          //     child: Icon(
          //       Icons.share,
          //       size: 20,
          //       color: Colors.black,
          //     ),
          //   ),
          // ),
          // const SizedBox(
          //   width: 15,
          // ),
          InkWell(
            splashColor: textGrayColor,
            highlightColor: white,
            onTap: () {
              showAlertDialog(context, id.toString() ?? "", index);
            },
            child: CircleAvatar(
              radius: 15,
              backgroundColor: indicatorColor,
              child: Image.asset(
                "assets/icons/delete.png",
                height: 18,
                width: 18,
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          )
        ],
        shape:
            const Border(bottom: BorderSide(color: indicatorColor, width: 0)),
        elevation: 0,
        backgroundColor: appBarColor,
        iconTheme: const IconThemeData(color: appIconColor),
      ),
      body: GetX<LocalContactController>(builder: (context) {
        return controller.loading.value
            ? const Center(
                child: BoldTextView(
                  text: "No contact details found",
                ),
              )
            : Stack(
                alignment: Alignment.topCenter,
                children: [
                  Column(
                    children: [
                      const SizedBox(
                        height: 70,
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20)),
                            boxShadow: [
                              BoxShadow(
                                color: gray1,
                                offset: Offset(
                                  5.0,
                                  5.0,
                                ),
                                blurRadius: 10.0,
                                spreadRadius: 2.0,
                              ), //BoxShadow
                              BoxShadow(
                                color: Colors.greenAccent,
                                offset: Offset(0.0, 0.0),
                                blurRadius: 0.0,
                                spreadRadius: 0.0,
                              ), //BoxShadow
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 60,
                              ),
                              BoldTextView(
                                text: controller.contactDetail.value.data?.name
                                        ?.capitalize ??
                                    "",
                                maxLines: 3,
                                textSize: 22,
                                color: textColor,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              RegularTextView(
                                text:
                                    "${controller.contactDetail.value.data?.position?.capitalize ?? ""} at ${controller.contactDetail.value.data?.company?.capitalize ?? ""}",
                                maxLine: 5,
                                textAlign: TextAlign.center,
                                textSize: 16,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Expanded(
                                child: Theme(
                                  data: ThemeData(
                                      splashColor: Colors.transparent),
                                  child: DefaultTabController(
                                    initialIndex: 0,
                                    length: myTabs.length,
                                    child: Scaffold(
                                      backgroundColor: white,
                                      appBar: TabBar(
                                          padding: EdgeInsets.zero,
                                          isScrollable: false,
                                          tabAlignment: TabAlignment.fill,
                                          labelColor: textColor,
                                          unselectedLabelColor: grey10,
                                          indicatorColor: textColor,
                                          indicatorSize:
                                              TabBarIndicatorSize.tab,
                                          labelStyle: const TextStyle(
                                              fontSize: 18,
                                              fontFamily: "figtree_medium",
                                              fontWeight: FontWeight.w500),
                                          onTap: (index) {},
                                          tabs: myTabs),
                                      body: TabBarView(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        children: [
                                          profileWidget(),
                                          companyWidget(),
                                          noteWidget()
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 25,
                    child: circularImage(
                        url: controller.contactDetail.value.data?.avatar ?? "",
                        shortName:
                            controller.contactDetail.value.data?.shortName ??
                                ""),
                  ),
                ],
              );
      }),
    );
  }

  Widget profileWidget({url, shortName}) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListTile(
            title: const BoldTextView(
              text: "Name",
              textSize: 18,
              textAlign: TextAlign.start,
              color: textColor,
            ),
            subtitle: RegularTextView(
              text: controller.contactDetail.value.data?.name?.capitalize ?? "",
              textSize: 16,
              maxLine: 3,
              color: textColor,
            ),
          ),
          const Divider(
            thickness: 1,
            color: BorderLight,
          ),
          ListTile(
            title: const BoldTextView(
              text: "Email",
              textSize: 18,
              textAlign: TextAlign.start,
              color: textColor,
            ),
            subtitle: RegularTextView(
              text: controller.contactDetail.value.data?.email ?? "",
              textSize: 16,
              maxLine: 3,
              color: textColor,
            ),
          ),
          const Divider(
            thickness: 1,
            color: BorderLight,
          ),
          ListTile(
            title: const BoldTextView(
              text: "Mobile No.",
              textSize: 18,
              textAlign: TextAlign.start,
              color: textColor,
            ),
            subtitle: RegularTextView(
              text: controller.contactDetail.value.data?.mobile ?? "",
              textSize: 16,
              maxLine: 3,
              color: textColor,
            ),
          ),
          const Divider(
            thickness: 1,
            color: BorderLight,
          ),
          ListTile(
            title: const BoldTextView(
              text: "Title",
              textSize: 18,
              textAlign: TextAlign.start,
              color: textColor,
            ),
            subtitle: RegularTextView(
              text: controller.contactDetail.value.data?.position?.capitalize ??
                  "",
              textSize: 16,
              maxLine: 3,
              color: textColor,
            ),
          ),
          const Divider(
            thickness: 1,
            color: BorderLight,
          )
        ],
      ),
    );
  }

  Widget companyWidget({url, shortName}) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListTile(
            title: const BoldTextView(
              text: "Company Name",
              textSize: 18,
              textAlign: TextAlign.start,
              color: textColor,
            ),
            subtitle: RegularTextView(
              text: controller.contactDetail.value.data?.company?.capitalize ??
                  "",
              textSize: 16,
              maxLine: 3,
              color: textColor,
            ),
          ),
          const Divider(
            thickness: 1,
            color: BorderLight,
          ),
          ListTile(
            title: const BoldTextView(
              text: "Website",
              textSize: 18,
              textAlign: TextAlign.start,
              color: textColor,
            ),
            subtitle: RegularTextView(
              text: controller.contactDetail.value.data?.website ?? "",
              textSize: 16,
              maxLine: 3,
              color: textColor,
            ),
            trailing: controller.contactDetail.value.data?.website != null &&
                    controller.contactDetail.value.data!.website!
                        .toString()
                        .isNotEmpty
                ? GestureDetector(
                    onTap: () {
                      Clipboard.setData(ClipboardData(
                          text: controller.contactDetail.value.data?.website ??
                              ""));
                      Get.snackbar('Copied!', 'Text copied to clipboard.',
                          snackPosition: SnackPosition.BOTTOM);
                    },
                    child: const Icon(
                      Icons.copy,
                      color: Colors.black,
                    ))
                : const SizedBox(),
          ),
          const Divider(
            thickness: 1,
            color: BorderLight,
          ),
          ListTile(
            title: const BoldTextView(
              text: "Contact No.",
              textSize: 18,
              textAlign: TextAlign.start,
              color: textColor,
            ),
            subtitle: RegularTextView(
              text: controller.contactDetail.value.data?.mobile ?? "",
              textSize: 16,
              maxLine: 3,
              color: textColor,
            ),
          ),
          const Divider(
            thickness: 1,
            color: BorderLight,
          ),
        ],
      ),
    );
  }

  Widget noteWidget({url, shortName}) {
    return Column(
      children: [
        ListTile(
          title: const BoldTextView(
            text: "Notes",
            textSize: 18,
            textAlign: TextAlign.start,
          ),
          subtitle: RegularTextView(
            text: controller.contactDetail.value.data?.note ?? "",
            maxLine: 100,
            textSize: 16,
          ),
        ),
        const Divider(
          thickness: 1,
          color: BorderLight,
        ),
      ],
    );
  }

  Widget circularImage({url, shortName}) {
    return CircleAvatar(
      radius: 45,
      backgroundColor: indicatorColor,
      child: url != null && url.toString().isNotEmpty
          ? Container(
              decoration: BoxDecoration(
                border: Border.all(color: primaryColor, width: 0),
                shape: BoxShape.rectangle,
                borderRadius: const BorderRadius.all(Radius.circular(45)),
              ),
              child: CircleAvatar(
                backgroundImage: NetworkImage(url),
                backgroundColor: indicatorColor,
                radius: 45,
              ),
            ) /*CircleAvatar(backgroundImage: NetworkImage(url))*/
          : Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: indicatorColor,
                borderRadius: const BorderRadius.all(Radius.circular(45)),
                border: Border.all(color: Colors.transparent, width: 0),
              ),
              child: Center(
                  child: BoldTextView(
                text: shortName ?? "",
                textAlign: TextAlign.center,
                textSize: 32,
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
    for (var i = 0; i < numWords; i++) {
      initials += '${names[i][0]}';
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
                          child: customTextView(
                            text: "Are you sure you want to delete?",
                            textSize: 16,
                            maxLines: 2,
                          ),
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                        Center(
                          child: GestureDetector(
                            onTap: () async {
                              Navigator.of(context).pop();
                              controller.loading.value = true;
                              await leadsController.deleteLeads({
                                "id": controller.contactDetail.value.data?.id ??
                                    ""
                              }, context, index);
                              print("lead deleted====");
                              controller.loading.value = false;
                              Get.back();
                              Get.back();

                              // controller.deleteOneRecordById(id, index);
                              // ScaffoldMessenger.of(context).showSnackBar(
                              //     const SnackBar(
                              //         content: Text("Contact Deleted")));
                              // Get.back();
                              // Get.back();
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
}
