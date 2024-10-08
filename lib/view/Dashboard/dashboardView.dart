import 'dart:ui';
import 'package:cphi/theme/app_theme.dart';
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
                        _showLogoutDialog(context);
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
                          _showExportLeadBottomSheet(context);
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
                      width: MediaQuery.of(context).size.width * 0.5,
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
  List<BottomNavigationBarItem> buildBottomMenu() {
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

  // Method to show the export lead bottom sheet
  void _showExportLeadBottomSheet(BuildContext context) {
    _showExportLeadBottomSheetMethod(context);
  }

  // The updated bottom sheet method with date and time selection
  void _showExportLeadBottomSheetMethod(BuildContext context) {
    DateTime? startDateTime;
    DateTime? endDateTime;

    // Controllers for TextFields
    TextEditingController startDateTimeController = TextEditingController();
    TextEditingController endDateTimeController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 50,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: labelColor,
                      borderRadius: AppBorderRadius.small,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  'Select Range',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 5),
                const Text(
                  'Select the range you want to export leads for.',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 20),

                // Start Date/Time Picker
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey), // Outlined box
                    borderRadius: AppBorderRadius.small,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          readOnly: true, // Prevents manual editing
                          decoration: const InputDecoration(
                            hintText: 'Start Date/Time', // Placeholder
                            border: InputBorder.none, // No internal border
                            contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                          ),
                          controller: startDateTimeController,
                          onTap: () async {
                            // Select Date
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: startDateTime ?? DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101),
                            );
                            if (pickedDate != null) {
                              // Select Time after Date
                              TimeOfDay? pickedTime = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              if (pickedTime != null) {
                                startDateTime = DateTime(
                                  pickedDate.year,
                                  pickedDate.month,
                                  pickedDate.day,
                                  pickedTime.hour,
                                  pickedTime.minute,
                                );
                                // Update controller with selected date and time
                                startDateTimeController.text =
                                "${pickedDate.toLocal().toString().split(' ')[0]} ${pickedTime.format(context)}";
                              }
                            }
                          },
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.calendar_today, color: labelColor),
                        onPressed: () async {
                          // Select Date
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: startDateTime ?? DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                          );
                          if (pickedDate != null) {
                            // Select Time after Date
                            TimeOfDay? pickedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (pickedTime != null) {
                              startDateTime = DateTime(
                                pickedDate.year,
                                pickedDate.month,
                                pickedDate.day,
                                pickedTime.hour,
                                pickedTime.minute,
                              );
                              // Update controller with selected date and time
                              startDateTimeController.text =
                              "${pickedDate.toLocal().toString().split(' ')[0]} ${pickedTime.format(context)}";
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),

                // End Date/Time Picker
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey), // Outlined box
                    borderRadius: AppBorderRadius.small,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          readOnly: true, // Prevents manual editing
                          decoration: const InputDecoration(
                            hintText: 'End Date/Time', // Placeholder
                            border: InputBorder.none, // No internal border
                            contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                          ),
                          controller: endDateTimeController,
                          onTap: () async {
                            // Select Date
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: endDateTime ?? DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101),
                            );
                            if (pickedDate != null) {
                              // Select Time after Date
                              TimeOfDay? pickedTime = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              if (pickedTime != null) {
                                endDateTime = DateTime(
                                  pickedDate.year,
                                  pickedDate.month,
                                  pickedDate.day,
                                  pickedTime.hour,
                                  pickedTime.minute,
                                );
                                // Update controller with selected date and time
                                endDateTimeController.text =
                                "${pickedDate.toLocal().toString().split(' ')[0]} ${pickedTime.format(context)}";
                              }
                            }
                          },
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.calendar_today, color: labelColor),
                        onPressed: () async {
                          // Select Date
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: endDateTime ?? DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                          );
                          if (pickedDate != null) {
                            // Select Time after Date
                            TimeOfDay? pickedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (pickedTime != null) {
                              endDateTime = DateTime(
                                pickedDate.year,
                                pickedDate.month,
                                pickedDate.day,
                                pickedTime.hour,
                                pickedTime.minute,
                              );
                              // Update controller with selected date and time
                              endDateTimeController.text =
                              "${pickedDate.toLocal().toString().split(' ')[0]} ${pickedTime.format(context)}";
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Export Lead Button
                GestureDetector(
                  onTap: () {
                    // Handle export logic here
                    if (startDateTime != null && endDateTime != null) {
                      // Example: Validate that endDateTime is after startDateTime
                      if (endDateTime!.isAfter(startDateTime!)) {
                        // Proceed with export
                        print("Exporting leads from $startDateTime to $endDateTime");
                        // TODO: Implement your export logic here

                        Get.back(); // Close the bottom sheet after export
                      } else {
                        // Show an error if end date is before start date
                        Get.snackbar(
                          'Error',
                          'End Date/Time must be after Start Date/Time.',
                          backgroundColor: Colors.redAccent,
                          colorText: Colors.white,
                        );
                      }
                    } else {
                      // Show an error if dates are not selected
                      Get.snackbar(
                        'Error',
                        'Please select both start and end date/time.',
                        backgroundColor: Colors.redAccent,
                        colorText: Colors.white,
                      );
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
                    decoration: const BoxDecoration(
                      color: blackGrey,
                      shape: BoxShape.rectangle,
                      borderRadius: AppBorderRadius.medium
                    ),
                    child: const Text(
                      "Export Lead",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        fontFamily: "figtree_semibold",
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
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
