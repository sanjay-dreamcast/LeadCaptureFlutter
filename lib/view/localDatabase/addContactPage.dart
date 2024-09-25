import 'package:contacts_service/contacts_service.dart';
import 'package:cphi/theme/app_colors.dart';
import 'package:cphi/view/localDatabase/localContactController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:permission_handler/permission_handler.dart';

import '../customerWidget/boldTextView.dart';
import '../customerWidget/toolbarTitle.dart';

class AddContactView extends GetView<LocalContactController> {
  Contact contact;
  AddContactView({Key? key, required this.contact}) : super(key: key);

  static const routeName = "/AddContactView";

  // PostalAddress address = PostalAddress(label: "Home");
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: false,
          title: const ToolbarTitle(
            title: "Add to contact",
            color: Colors.black,
          ),
          shape:
              const Border(bottom: BorderSide(color: indicatorColor, width: 0)),
          elevation: 0,
          backgroundColor: appBarColor,
          iconTheme: const IconThemeData(color: Colors.black)),
      body: Container(
        padding: EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Full name',
                ),
                initialValue: contact.displayName?.capitalize ?? "",
                onSaved: (v) => contact.givenName = v,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Phone'),
                initialValue: contact.phones?[0]?.value,
                onSaved: (v) =>
                    contact.phones = [Item(label: "mobile", value: v)],
                keyboardType: TextInputType.phone,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'E-mail'),
                initialValue: contact.emails?[0]?.value,
                onSaved: (v) =>
                    contact.emails = [Item(label: "work", value: v)],
                keyboardType: TextInputType.emailAddress,
              ),
              TextFormField(
                maxLines: 2,
                decoration: const InputDecoration(labelText: 'Company'),
                initialValue: contact.company?.capitalize ?? "",
                onSaved: (v) => contact.company = v,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Title'),
                initialValue: contact.jobTitle?.capitalize ?? "",
                onSaved: (v) => contact.jobTitle = v,
              ),
              const SizedBox(
                height: 40,
              ),
              Center(
                child: GestureDetector(
                  onTap: () async {
                    await _getContactPermission();
                    _formKey.currentState?.save();
                    ContactsService.addContact(contact);
                    Get.back(result: "true");
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    height: 50,
                    width: 150,
                    child: const Center(
                      child: BoldTextView(
                        text: "Save Contact",
                        color: white,
                        textSize: 16,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<PermissionStatus> _getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }
}
