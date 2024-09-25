import 'package:cphi/theme/strings.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX
import '../../api_repository/api_service.dart';
import '../../theme/app_colors.dart';
import '../localDatabase/EventsController.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});
  static const routeName = "/EventsPage";

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  final EventsController eventsController = Get.put(EventsController(Get.find<ApiService>())); // Initialize the EventsController

  @override
  void initState() {
    super.initState();
    fetchEvents(); // Fetch events when the screen is initialized
  }

  Future<void> fetchEvents() async {
    dynamic requestBody = {
      // Your request parameters
    };
    await eventsController.fetchEvents(requestBody); // Call fetchEvents from EventsController
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _loginStripUI(),
            SearchBar(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
              child: Text(
                MyStrings.event_happening_with_dreamcast,
                style: TextStyle(
                  color: grey10,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  fontFamily: "Figtree",
                ),
              ),
            ),
            Expanded(child: _eventList()),
            _uncategorizedEvent()
          ],
        ),
      ),
    );
  }

  Widget _loginStripUI() {
    return Container(
      color: textColor,
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
            fontWeight: FontWeight.normal,
            fontFamily: "Figtree",
          ),
          children: [
            TextSpan(
              text: MyStrings.logIn,
              style: const TextStyle(
                fontFamily: "Figtree",
                color: Colors.white,
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.w800,
                fontSize: 14,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  print('Continue with Log In clicked');
                },
            ),
          ],
        ),
      ),
    );
  }

  Widget _eventList() {
    return Obx(() { // Use Obx to reactively update the UI based on eventsController
      if (eventsController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      } else if (eventsController.errorMessage.isNotEmpty) {
        return Center(child: Text(eventsController.errorMessage.value));
      } else {
        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          itemCount: eventsController.eventsList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: GestureDetector(
                onTap: () {
                  print('Event tapped: ${eventsController.eventsList[index].name}');
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: white80),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          eventsController.eventsList[index].name ?? 'Unnamed Event',
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
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
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
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(width: 20),
                Icon(
                  Icons.arrow_forward_ios_sharp,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SearchBar extends StatefulWidget {
  const SearchBar({super.key});

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextField(
        controller: _searchController,
        onChanged: (value) {
          setState(() {}); // Triggers rebuild to show/hide the clear button
        },
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: grayNew,
            size: 35.0,
          ),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
            icon: Icon(Icons.close),
            color: Colors.grey,
            onPressed: () {
              _searchController.clear();
              setState(() {}); // Rebuild to hide the clear button
            },
          )
              : null,
          hintText: 'Search here',
          hintStyle: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w600,
            fontSize: 16,
            fontFamily: "Figtree",
          ),
          filled: true,
          fillColor: Colors.grey.shade200,
          contentPadding: EdgeInsets.all(0.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(35.0),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
