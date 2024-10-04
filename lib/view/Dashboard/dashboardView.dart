import 'dart:ui';

import 'package:cphi/view/Home/homeView.dart';
import 'package:cphi/view/customerWidget/semiBoldTextView.dart';
import 'package:cphi/view/localDatabase/LocalContactPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../theme/app_colors.dart';
import '../localDatabase/SharedPrefController.dart';
import '../localDatabase/event_data_Model.dart';
import 'dashBoardController.dart';

class DashboardPage extends StatelessWidget {
  DashboardPage({Key? key}) : super(key: key);
  static const routeName = "/DashboardPage";

  final DashboardController controller = Get.put(DashboardController());
  final Sharedprefcontroller sharedPrefController = Get.put(Sharedprefcontroller()); // Instantiate Sharedprefcontroller
  List<String> bottomTitle = [
    "Home",
    "Leads",
  ];

  Widget build(BuildContext context) {
    // Retrieve the passed arguments
    final args = Get.arguments as Map<String, dynamic>?;
    final eventDataJson = args?['eventData'] as Map<String, dynamic>?; // Get the JSON map
    final eventData = eventDataJson != null ? EventData.fromJson(eventDataJson) : null; // Convert to EventData


    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: GetBuilder<DashboardController>(
        builder: (_) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              automaticallyImplyLeading: false, // Hides the default back button
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(
                        Icons.arrow_back_ios_sharp,
                        color: Colors.black), // Left icon
                    onPressed: () {
                       Get.back();
                    },
                  ),
                   Column(
                    children: [
                      if (controller.tabIndex == 0) ...[
                         Text(
                           eventData?.name ?? 'No Name', // Centered title
                          style: TextStyle(
                              color: grey20Color,
                              fontSize: 12,
                              fontFamily: "figtree_medium",
                            fontWeight: FontWeight.w500,

                          ),
                        ),
                         Text(
                          sharedPrefController.loggedInUser.value?.name ?? 'Guest', // Replace `name` with your UserData property
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            fontFamily: "figtree_bold",
                          ),
                        ),
                      ],
                    ],
                  ),
                  if (controller.tabIndex == 0)
                    IconButton(
                    icon: const Icon(Icons.logout_sharp, color: Colors.black), // Right icon
                    onPressed: () {
                      // Handle right icon action here
                    },
                  ),
                  if (controller.tabIndex == 1)
                    Container(
                    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white, // Background color white
                      border: Border.all(
                        color: Colors.black, // Black border
                        width: 1, // Border width
                      ),
                      borderRadius: BorderRadius.circular(20), // Rounded corners
                    ),
                    child: InkWell(
                      onTap: () {
                        // Handle right icon action here
                      },
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.exit_to_app,
                            color: Colors.black,
                          ),
                          SizedBox(width: 5), // Space between icon and text
                          Text(
                            'Export', // Button text
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16, // Adjust text size as needed
                              fontFamily: 'figtree_semibold', // Custom font if necessary
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            body: Stack(
              children: [
                SafeArea(
                    child: IndexedStack(
                  index: controller.tabIndex,
                  children: [HomePgae(eventData: eventData), LocalContactViewPage()],
                )),
              ],
            ),
            bottomNavigationBar: Theme(
              data: ThemeData(splashColor: Colors.transparent),
              child: SizedBox(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: controller.tabIndex == 0
                          ? Alignment.bottomLeft
                          : controller.tabIndex == 1
                              ? Alignment.bottomRight
                              : Alignment.bottomRight,
                      child: Container(
                        height: 2,
                        color: Colors.black,
                        width: context.width * 0.5,
                      ),
                    ),
                    BottomNavigationBar(
                        // type: BottomNavigationBarType.fixed,
                        backgroundColor: white,
                        onTap: controller.changeTabIndex,
                        currentIndex: controller.tabIndex,
                        unselectedItemColor: textGrayColor,
                        selectedItemColor: const Color(0xff333333),
                        showSelectedLabels: true,
                        showUnselectedLabels: true,
                        unselectedFontSize: 12,
                        selectedFontSize: 12,
                        items: buildBottomMenu()),
                  ],
                ),
              ),
            ),
            /* floatingActionButton: controller.tabIndex == 0
                ? InkWell(
                    onTap: () async {
                      await controller.getBadgeUrl();
                      Get.toNamed(QrProfilePage.routeName);
                    },
                    child:
                        Image.asset("assets/icons/scan_icon.png", height: 70))
                : const SizedBox(),*/
          );
        },
      ),
    );
  }

  buildBottomMenu() {
    return [
      BottomNavigationBarItem(
        icon: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 7,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const ImageIcon(
                  AssetImage("assets/icons/home_menu.png"),
                  size: 25,
                ),
                const SizedBox(
                  width: 10,
                ),
                SemiBoldTextView(
                    text: "Home",
                    textSize: 18,
                    color: controller.tabIndex == 0
                        ? const Color(0xff333333)
                        : const Color(0xff8A8A8E))
              ],
            ),
          ],
        ),
        label: "",
      ),
      BottomNavigationBarItem(
        icon: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 7,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const ImageIcon(
                  AssetImage("assets/icons/lead_menu.png"),
                  size: 25,
                ),
                const SizedBox(
                  width: 10,
                ),
                SemiBoldTextView(
                    text: "Leads",
                    textSize: 18,
                    color: controller.tabIndex == 1
                        ? const Color(0xff333333)
                        : const Color(0xff8A8A8E))
              ],
            ),
          ],
        ),
        label: "",
      ),
    ];
  }

}



