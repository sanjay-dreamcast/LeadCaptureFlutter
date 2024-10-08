import 'dart:ui';
import 'package:cphi/view/Home/homeView.dart';
import 'package:cphi/view/customerWidget/semiBoldTextView.dart';
import 'package:cphi/view/localDatabase/LocalContactPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>?;
    final eventDataJson = args?['eventData'] as Map<String, dynamic>?;
    final eventData = eventDataJson != null ? EventData.fromJson(eventDataJson) : null;

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
              automaticallyImplyLeading: false,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_sharp, color: Colors.black),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  Column(
                    children: [
                      if (controller.tabIndex == 0) ...[
                        const Text(
                          'User Details',
                          style: TextStyle(
                            color: grey20Color,
                            fontSize: 12,
                            fontFamily: "figtree_medium",
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          sharedPrefController.loggedInUser.value?.name ?? 'Guest',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            fontFamily: "figtree_bold",
                          ),
                        ),
                      ],
                    ],
                  ),
                  if (controller.tabIndex == 0)
                    IconButton(
                      icon: const Icon(Icons.logout_sharp, color: Colors.black),
                      onPressed: () {
                       // _showLogoutDialog(context);
                      },
                    ),
                  if (controller.tabIndex == 1)
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: InkWell(
                        onTap: () {
                          // Handle export action
                        },
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.exit_to_app, color: Colors.black),
                            SizedBox(width: 5),
                            Text(
                              'Export',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'figtree_semibold',
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
                    children: [
                      HomePgae(eventData: eventData),
                      LocalContactViewPage(),
                    ],
                  ),
                ),
              ],
            ),
            bottomNavigationBar: Theme(
              data: ThemeData(splashColor: Colors.transparent),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: controller.tabIndex == 0 ? Alignment.bottomLeft : Alignment.bottomRight,
                    child: Container(
                      height: 2,
                      color: Colors.black,
                      width: context.width * 0.5,
                    ),
                  ),
                  BottomNavigationBar(
                    backgroundColor: white,
                    onTap: controller.changeTabIndex,
                    currentIndex: controller.tabIndex,
                    unselectedItemColor: textGrayColor,
                    selectedItemColor: const Color(0xff333333),
                    showSelectedLabels: true,
                    showUnselectedLabels: true,
                    unselectedFontSize: 12,
                    selectedFontSize: 12,
                    items: buildBottomMenu(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Method to build the bottom menu
  buildBottomMenu() {
    return [
      BottomNavigationBarItem(
        icon: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 7),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const ImageIcon(AssetImage("assets/icons/home_menu.png"), size: 25),
                const SizedBox(width: 10),
                SemiBoldTextView(
                  text: "Home",
                  textSize: 18,
                  color: controller.tabIndex == 0 ? const Color(0xff333333) : const Color(0xff8A8A8E),
                ),
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
            const SizedBox(height: 7),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const ImageIcon(AssetImage("assets/icons/lead_menu.png"), size: 25),
                const SizedBox(width: 10),
                SemiBoldTextView(
                  text: "Leads",
                  textSize: 18,
                  color: controller.tabIndex == 1 ? const Color(0xff333333) : const Color(0xff8A8A8E),
                ),
              ],
            ),
          ],
        ),
        label: "",
      ),
    ];
  }

  // Method to show the logout confirmation dialog
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout Confirmation'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () {
                Get.back(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await sharedPrefController.removeUser(); // Clear shared preferences
                Get.offAllNamed('/EventScreen'); // Navigate to EventScreen
              },
              child: const Text('Logout'),

            ),
          ],
        );
      },
    );
  }
}
