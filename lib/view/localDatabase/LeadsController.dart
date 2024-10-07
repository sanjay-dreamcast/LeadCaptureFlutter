



import 'package:cphi/api_repository/api_service.dart';
import 'package:cphi/model/LeadsBody.dart';
import 'package:cphi/model/LeadsData.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../model/BaseApiModel.dart';
import '../../model/Resource.dart';
import '../../model/add_leads.dart';
import '../../theme/strings.dart';
import '../../utils/UniversalAlertDialog.dart';
import '../../utils/connectivity_helper.dart';
import 'EventsController.dart';

class LeadsController extends GetxController{
  final ApiService apiService;
  LeadsController(this.apiService);
  var addLeadsData = Resource<BaseApiModel>.initial().obs;
  var leadBodyData = Resource<LeadsBodyData>.initial().obs;
// Access the EventsController
  final EventsController eventsController = Get.find<EventsController>();

// Getter to access the leads list
  List<LeadsData>? get leads {
    return leadBodyData.value.data?.leads; // Return the leads list or null
  }
  @override
  void onInit() {
    super.onInit();
    // {"event_id":"3b9aca0c","last_insert_id":""}@@Msg@@

    getLeadsList(
      {"event_id": eventsController.eventData.value.id,"last_insert_id":""},Get.context!
    );
  }
  Future<void> addLeads(dynamic body, BuildContext context) async {
    // Set to loading state initially
    addLeadsData.value = Resource.loading();

    bool hasInternet = await ConnectivityHelper.checkInternetConnection();
    if (!hasInternet) {
      addLeadsData.value = Resource.error(MyStrings.NoInternetconnected);
      return;
    }

    try {
      BaseApiModel<BaseApiModel> model = await apiService.addLeads(body);
      if (model.status == true && model.statusCode == 200) {
        addLeadsData.value = Resource.success(
          data: model.data, // this is userdata
          message: model.message,
        );
        UniversalAlertDialog.showAlertDialog(
          Get.context!,
          title: "Success!",
          message: addLeadsData.value.message,
          isNegativeButtonVisible: false,
          positiveButtonLabel: "Done"
        ).then((_) {
          // Reset the flag when the dialog is dismissed
        });
      } else {
        // Handle error
        addLeadsData.value = Resource.error(
          model.message ?? MyStrings.someErrorOccurred,
          data: model.data,
        );
        WidgetsBinding.instance.addPostFrameCallback((_) {
          UniversalAlertDialog.showAlertDialog(
            context,
            message: addLeadsData.value.message,
            isNegativeButtonVisible: false,
          ).then((_) {
            // Reset the flag when the dialog is dismissed
          });
        });
      }
    } catch (e) {
      print("addLeadsData catch $e");
      // Handle exceptions or unexpected errors
      addLeadsData.value = Resource.error(MyStrings.somethingWentWrong);
      print("catch ${addLeadsData.value.message}");
    }
  }


  Future<void> getLeadsList(dynamic body, BuildContext context) async {
    // Set to loading state initially
    leadBodyData.value = Resource.loading();

    bool hasInternet = await ConnectivityHelper.checkInternetConnection();
    if (!hasInternet) {
      leadBodyData.value = Resource.error(MyStrings.NoInternetconnected);
      return;
    }

    try {
      // Assuming UserModel is the type for the body
      BaseApiModel<LeadsBodyData> model = await apiService.getLeadsData(body);
      if (model.status == true && model.statusCode == 200) {
        leadBodyData.value = Resource.success(
          data: model.data, // this is userdata
          message: model.message,
        );
        print(leadBodyData.value.data);
      } else {
        // Handle error
        leadBodyData.value = Resource.error(
          model.message ?? MyStrings.someErrorOccurred,
          data: model.data,
        );
        WidgetsBinding.instance.addPostFrameCallback((_) {
          UniversalAlertDialog.showAlertDialog(
            context,
            message: leadBodyData.value.message,
            isNegativeButtonVisible: false,
          ).then((_) {
            // Reset the flag when the dialog is dismissed
          });
        });
      }
    } catch (e) {
      print("verifyOtpResource catch $e");
      // Handle exceptions or unexpected errors
      leadBodyData.value = Resource.error(MyStrings.somethingWentWrong);
    }
  }


}