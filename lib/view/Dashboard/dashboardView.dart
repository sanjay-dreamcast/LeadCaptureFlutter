import 'package:cphi/view/Home/homeView.dart';
import 'package:cphi/view/customerWidget/semiBoldTextView.dart';
import 'package:cphi/view/localDatabase/LocalContactPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../theme/app_colors.dart';
import 'dashBoardController.dart';

class DashboardPage extends StatelessWidget {
  DashboardPage({Key? key}) : super(key: key);
  static const routeName = "/DashboardPage";

  final DashboardController controller = Get.put(DashboardController());
  List<String> bottomTitle = [
    "Home",
    "Leads",
  ];

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: GetBuilder<DashboardController>(
        builder: (_) {
          return Scaffold(
            body: Stack(
              children: [
                SafeArea(
                    child: IndexedStack(
                  index: controller.tabIndex,
                  children: [HomePgae(), LocalContactViewPage()],
                )),
              ],
            ),
            bottomNavigationBar: Theme(
              data: ThemeData(splashColor: Colors.transparent),
              child: SizedBox(
                height: 60,
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
