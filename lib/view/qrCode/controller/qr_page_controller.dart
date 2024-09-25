import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class QrPageController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  var loading = false.obs;
  var userFound = false.obs;
  var qrBadge = "".obs;
  //final AuthenticationManager controller = Get.find();
  var vCard = ContactCard.create("", "", "", "", "", "", "").obs;

  Future<void> getUserDetail(BuildContext context, uniqueCode) async {
    loading(true);
    // UserModelModel? model = await apiService.getUserDetailByCode(uniqueCode);
    // loading(false);
    // if (model.body?.status ?? false) {
    //   // Get.to(SaveContactPage(
    //   //   userModel: model,
    //   //   code: uniqueCode,
    //   // ));
    // } else {
    //  // UiHelper.showFailureMsg(context, "Data not found");
    // }
  }

  Future<void> saveUserToContact(BuildContext context, dynamic data) async {
    loading(true);
    // UniqueCodeModel? model =
    //   //  await apiService.saveUserToContact(jsonRequest: data);
    // if (model?.status ?? false) {
    //   Get.back();
    //  // UiHelper.showSuccessMsg(context, model.body?.message ?? "");
    // } else {
    //  // UiHelper.showFailureMsg(context, model?.message ?? "");
    // }
    loading(false);
  }
}

class ContactCard {
  String? name;
  String? mobile;
  String? email;
  String? company;
  String? uniqueCode;
  String? avtar;
  String shortName;
  ContactCard.create(this.name, this.email, this.company, this.uniqueCode,
      this.avtar, this.shortName, this.mobile);
}
