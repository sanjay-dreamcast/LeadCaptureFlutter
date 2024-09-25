

import 'package:get/get.dart';

import '../../api_repository/api_service.dart';
import 'event_data_Model.dart';


class EventsController extends GetxController {
  final ApiService apiService;

  var isLoading = false.obs; // Loading state
  var eventsList = <Event>[].obs; // List of events
  var errorMessage = ''.obs; // Error message

  EventsController(this.apiService);

  // Method to fetch events
  Future<void> fetchEvents(dynamic body) async {
    isLoading.value = true; // Set loading state to true
    try {
      EventApiResponse response = await apiService.getEventsList(body);
      if (response.status == true) {
        // Assuming the body is a list of events
        eventsList.value = response.body ?? []; // Update events list
      } else {
        errorMessage.value = response.message ?? 'Failed to fetch events.';
      }
    } catch (e) {
      errorMessage.value = 'An error occurred: $e'; // Update error message
    } finally {
      isLoading.value = false; // Reset loading state
    }
  }
}
