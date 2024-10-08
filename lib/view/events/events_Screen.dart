import 'dart:ui';

import 'package:cphi/theme/strings.dart';
import 'package:cphi/utils/LifecycleController.dart';
import 'package:cphi/utils/UniversalAlertDialog.dart';
import 'package:cphi/view/customerWidget/search_bar_widget.dart';
import 'package:cphi/view/localDatabase/LoginController.dart';
import 'package:cphi/view/login/bottomsheet_helper.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart'; // Import GetX
import '../../api_repository/api_service.dart';
import '../../model/Status.dart';
import '../../theme/app_colors.dart';
import '../Dashboard/dashboardView.dart';
import '../localDatabase/EventsController.dart';
import '../localDatabase/SharedPrefController.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  static const routeName = "/EventsPage";

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen>
    with WidgetsBindingObserver {
  final EventsController eventsController = Get.put(EventsController(
      Get.find<ApiService>())); // Initialize the EventsController
  final LifecycleController lifecycleController =
      Get.put(LifecycleController());
  final Sharedprefcontroller sharedPrefController =
      Get.put(Sharedprefcontroller());
  final LoginController loginController = Get.put(LoginController(
      Get.find<ApiService>())); // Initialize the EventsController

  @override
  void initState() {
    super.initState();
    fetchEvents();

    // Register the observer
    WidgetsBinding.instance.addObserver(this);
  }

  Future<void> fetchEvents() async {
    dynamic requestBody = {};
    await eventsController.fetchEvents(requestBody,
        isRefresh: true); // Call fetchEvents from EventsController
  }

  Future<void> _onRefresh() async {
    await fetchEvents();
  }

  @override
  void dispose() {
    // Unregister the observer
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Update the lifecycle state in the LifecycleController
    lifecycleController
        .updateLifecycleState(state); // Update through the controller

    // Additional logic based on the lifecycle state
    switch (state) {
      case AppLifecycleState.resumed:
        print("App is in the foreground");
        fetchEvents(); // Refresh events when app resumes
        break;
      case AppLifecycleState.paused:
        print("App is in the background");
        break;
      case AppLifecycleState.inactive:
        print("App is inactive");
        break;
      case AppLifecycleState.detached:
        print("App is detached");
        break;
      default:
        print("Unhandled app lifecycle state: $state");
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false, // Prevent resizing
        backgroundColor: Colors.white,
        body: RefreshIndicator(
          color: Colors.black, // Color of the spinner
          onRefresh: _onRefresh, // Call the _onRefresh method when swiped
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() {
                return loginController.isLoginButtonVisible.value
                    ? const SizedBox.shrink()
                    : _loginStripUI();
              }),
              SearchBarWidget(
                onSearch: (query) {
                  eventsController.filterEvents(query);
                },
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                child: Text(
                  MyStrings.event_happening_with_dreamcast,
                  style: TextStyle(
                    color: grey10,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    fontFamily: "figtree_medium",
                  ),
                ),
              ),
              Expanded(child: _eventList()),
              _uncategorizedEvent()
            ],
          ),
        ),
      ),
    );
  }

  Widget _loginStripUI() {
    return Container(
      color: blackGrey,
      padding: const EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: 40.0,
      ),
      alignment: Alignment.center,
      child: RichText(
        text: TextSpan(
          text: MyStrings.secureLeadTitle,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontFamily: "figtree_medium",
          ),
          children: [
            TextSpan(
              text: MyStrings.logIn,
              style: const TextStyle(
                fontFamily: "figtree_medium",
                color: Colors.white,
                decoration: TextDecoration.underline,
                fontSize: 14,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  print('Continue with Log In clicked');
                  BottomSheetHelper.showDynamicBottomSheet(context, (email) {
                    // This callback will be executed on successful email validation
                    print("Email validated successfully!${email}");
                    // loginController.verifyUser({"email": email ?? ""}, context);
                  });
                },
            ),
          ],
        ),
      ),
    );
  }

  Widget _eventList() {
    return Obx(() {
      switch (eventsController.eventResource.value.status) {
        case Status.loading:
          // Optionally return the current list of events with a loading indicator
          return const Center(child: CircularProgressIndicator());

        case Status.error:
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/ic_event.png',
                    width: 24,
                    height: 24,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    eventsController.eventResource.value.message ??
                        MyStrings.no_event_found,
                    style: const TextStyle(
                        color: blackGrey,
                        fontSize: 20,
                        fontFamily: "figtree_semibold"),
                  ),
                ],
              ),
            ),
          );

        case Status.success:
          final eventsList = eventsController.eventResource.value.data;
          print("Event List-> $eventsList");
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            itemCount: eventsList?.length ?? 0,
            itemBuilder: (context, index) {
              final event = eventsList?[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: GestureDetector(
                  onTap: () {
                    eventsController.setEventData(event);
                    // Get.offAndToNamed(DashboardPage.routeName);
                    sharedPrefController.loggedInUser.value.isNull
                        ? UniversalAlertDialog.showAlertDialog(
                            context,
                            title: "Alert",
                            message: "Please Login",
                            positiveButtonLabel: "OK",
                            isNegativeButtonVisible: false,
                          )
                        : Get.toNamed(
                            DashboardPage.routeName,
                            arguments: {
                              'eventData': event?.toJson()
                            }, // Pass the event data as a JSON map
                          ); // Pass arguments
                    print('Event tapped: ${event?.name}');
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 18),
                    decoration: BoxDecoration(
                      color: white_color,
                      border: Border.all(color: white80),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            event?.name ?? 'Unnamed Event',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Figtree",
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Icon(
                          Icons.arrow_forward_ios_sharp,
                          color: Colors.black,
                          size: 16.0,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );

        default:
          // Optional: Handle any unexpected state
          return const Center(child: Text("Unexpected error"));
      }
    });
  }

  Widget _uncategorizedEvent() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15),
      child: Center(
        child: GestureDetector(
          onTap: () {
            print('Custom button pressed!');
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
            decoration: const BoxDecoration(
              color: violet10,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(35)),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  MyStrings.uncategorized_event,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontFamily: "figtree_semibold"),
                ),
                SizedBox(width: 20),
                Icon(
                  Icons.arrow_forward_ios_sharp,
                  color: Colors.white,
                  size: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

// {"email":"gzg@gmail.com"}
// https://staging-eapp.godreamcast.com/lead_capture/api/app/v1/signin/verifyUsername
// {"status":false,"code":422,"message":"Validation failed","body":{"email":"Hmm, no account found with this email. Perhaps it's time to create a new account?"}}@@Msg@@
}
