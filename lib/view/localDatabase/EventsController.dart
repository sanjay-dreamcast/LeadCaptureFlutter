

import 'package:get/get.dart';

import '../../api_repository/api_service.dart';
import '../../model/Resource.dart';
import '../../utils/connectivity_helper.dart';
import 'database_helper.dart';
import 'event_data_Model.dart';


// class EventsController extends GetxController {
//   final ApiService apiService;
//
//   var isLoading = false.obs; // Loading state
//   var eventsList = <Event>[].obs; // List of events
//   var errorMessage = ''.obs; // Error message
//
//   EventsController(this.apiService);
//
//   // Method to fetch events
//   Future<void> fetchEvents(dynamic body) async {
//     isLoading.value = true; // Set loading state to true
//     try {
//       EventApiResponse response = await apiService.getEventsList(body);
//       if (response.status == true) {
//         // Assuming the body is a list of events
//         eventsList.value = response.body ?? []; // Update events list
//       } else {
//         errorMessage.value = response.message ?? 'Failed to fetch events.';
//       }
//     } catch (e) {
//       errorMessage.value = 'An error occurred: $e'; // Update error message
//     } finally {
//       isLoading.value = false; // Reset loading state
//     }
//   }
// }


class EventsController extends GetxController {
  final ApiService apiService;
  final DatabaseHelper _dbHelper = DatabaseHelper(); // Add DatabaseHelper

  var eventResource = Resource<List<EventData>>.loading().obs; // Use EventData instead of Event
  EventsController(this.apiService);

  List<EventData> allEvents = []; // Store all events for filtering


  Future<void> fetchEvents(dynamic body, {bool isRefresh = false}) async {
    if (!isRefresh) {
      // Set loading state only if not a refresh
      eventResource.value = Resource.loading();
    }

    // Load offline data immediately
    await _loadEventsFromDb();

    bool hasInternet = await ConnectivityHelper.checkInternetConnection();

    if (hasInternet) {
      // Attempt to fetch from API
      try {
        EventApiResponse response = await apiService.getEventsList(body);

        if (response.status == true) {
          await _dbHelper.insertEvents(response.body ?? []);
          // Update eventResource with the successful API response
          allEvents = response.body ?? [];
          eventResource.value = Resource.success(allEvents);
          print("fetchEvents Api Success");
        } else {
          // If API fails, show error message and retain offline data
          print("fetchEvents Api Failed");
          eventResource.value = Resource.error(response.message ?? 'Failed to fetch events.');
        }
      } catch (e) {
        print("Api Exception: $e");
        eventResource.value = Resource.error('An error occurred: $e');
      }
    } else {
      // If there's no internet, we already loaded the offline data
      print("No internet connection. Using offline data.");
    }
  }

  Future<void> _loadEventsFromDb() async {
    try {
      final events = await _dbHelper.getAllEvents();
      allEvents = events;
      print("allEventsDb $allEvents");
      if (events.isNotEmpty) {
        eventResource.value = Resource.success(events);
      } else {
        eventResource.value = Resource.error('No events available offline.');
      }
    } catch (e) {
      eventResource.value = Resource.error('Failed to load offline events: $e');
    }
  }




  void filterEvents(String query) {
    if (query.isEmpty) {
      eventResource.value = Resource.success(allEvents);
    } else {
      // Filter events based on the query
      final filteredEvents = allEvents.where((event) {
        final name = event.name?.toLowerCase() ?? '';
        return name.contains(query.toLowerCase());
      }).toList();
      print("allEvents_filteredEvents $filteredEvents");
      eventResource.value = Resource.success(filteredEvents);
    }
  }

}
