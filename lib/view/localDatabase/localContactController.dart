import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import '../../api_repository/api_service.dart';
import 'contactDetailModel.dart';
import 'localDataModel.dart';
import 'package:path/path.dart';

class LocalContactController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getLocalUser();
  }

  final loading = false.obs;

  Database? _database;

  ApiService apiService = Get.find<ApiService>();

  var localDataList = <LocalUser>[].obs;
  var headerList = <String>[
    "Name",
    "Email",
    "Mobile",
    "Company",
    "Title",
    "Website"
  ];
  var headers = <LocalUser>[].obs;
  var tempChatList = <LocalUser>[].obs;
  var contactDetail = ContactDetail().obs;

  Future openDb() async {
    if (_database == null) {
      _database = await openDatabase(
          join(await getDatabasesPath(),
              'contact.db'), //getting an error in this line for the join keyword
          version: 1, onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE LocalContact(id TEXT PRIMARY KEY , name TEXT, email TEXT, mobile TEXT, company TEXT, title TEXT,website TEXT)',
          //
        );
      });
    } else {}
  }

  inserUser(LocalUser user, BuildContext? context) async {
    // Get a reference to the database.
    await openDb();

    try {
      await _database?.insert('LocalContact', user.toMap());
      localDataList.add(user);
      tempChatList.add(user);
      tempChatList.refresh();
      localDataList.refresh();
    } catch (e, _) {
      print("error=======");
      ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
          content: e.toString().contains("1555")
              ? Text("Contact alreday exist")
              : Text(e.toString())));
      //  UiHelper.showFailureMsg(null, e.toString());
      print(e.toString());
    }
    // getLocalUser();
  }

  deleteOneRecordById(String id, int index) async {
    await openDb();
    await _database?.delete('LocalContact', where: 'id = ?', whereArgs: [id]);
    tempChatList.removeAt(index);
    tempChatList.refresh();
    localDataList.removeAt(index);
    localDataList.refresh();
    update();
  }

  searchContact(String text) async {
    if (text.isEmpty) {
      tempChatList.clear();
      tempChatList.addAll(localDataList);
      tempChatList.refresh();
      return;
    } else {
      tempChatList.clear();
      // Perform a query with the LIKE operator
      List<Map<String, Object?>>? maps = await _database?.query(
        'LocalContact',
        where: "name LIKE ? OR email LIKE ? OR mobile LIKE ? OR company LIKE ?",
        whereArgs: [
          '%$text%',
          '%$text%',
          '%$text%',
          '%$text%'
        ], // Use '%' as wildcard
      );
      maps?.forEach((row) => print(row));
      return List.generate(maps?.length ?? 0, (i) {
        var data = LocalUser(
          id: maps?[i]['id'] as String,
          name: maps?[i]['name'] as String,
          email: maps?[i]['email'] as String,
          mobile: maps?[i]['mobile'] as String,
          company: maps?[i]['company'] as String,
          title: maps?[i]['title'] as String,
          website: maps?[i]['website'] as String,
        );
        tempChatList.add(data);
        tempChatList.refresh();
      });
    }

    await openDb();
    List<Map<String, Object?>>? maps = await _database
        ?.rawQuery('SELECT * FROM LocalContact WHERE name=?', ['niti']);

    // Perform a query with the LIKE operator
    List<Map<String, Object?>>? result = await _database?.query(
      'LocalContact',
      where: "name LIKE ? OR email LIKE ? OR mobile LIKE ?",
      whereArgs: ['%a%'], // Use '%' as wildcard
    );

    result?.forEach((row) => print(row));

    print("data========");
    print(maps);
    return List.generate(maps?.length ?? 0, (i) {
      var data = LocalUser(
        id: maps?[i]['id'] as String,
        name: maps?[i]['name'] as String,
        email: maps?[i]['email'] as String,
        mobile: maps?[i]['mobile'] as String,
        company: maps?[i]['company'] as String,
        title: maps?[i]['title'] as String,
        website: maps?[i]['title'] as String,
      );
      print("data========");
      print(data);
    });
  }

  deleteAll() async {}

  // A method that retrieves all the dogs from the dogs table.
  getLocalUser() async {
    // Get a reference to the database.
    await openDb();
    // Query the table for all The Dogs.
    final List<Map<String, Object?>>? maps =
        await _database?.query('LocalContact');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps?.length ?? 0, (i) {
      var data = LocalUser(
        id: maps?[i]['id'] as String,
        name: maps?[i]['name'] as String,
        email: maps?[i]['email'] as String,
        mobile: maps?[i]['mobile'] as String,
        company: maps?[i]['company'] as String,
        title: maps?[i]['title'] as String,
        website: maps?[i]['website'] as String,
      );
      localDataList.add(data);
      tempChatList.add(data);
      localDataList.refresh();
      tempChatList.refresh();
    });
  }

  void filterSearchResults(String query) {
    if (query.isNotEmpty) {
      List<LocalUser> dummyListData = [];
      for (var item in tempChatList) {
        if ((item.name.toLowerCase())!.contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      }
      tempChatList.clear();
      tempChatList.addAll(dummyListData);
      tempChatList.refresh();
      return;
    } else {
      tempChatList.clear();
      tempChatList.addAll(localDataList);
      tempChatList.refresh();
    }
  }

  Future<bool> checkNetwork() async {
    bool isConnected = false;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isConnected = true;
      }
    } on SocketException catch (_) {
      isConnected = false;
    }
    return isConnected;
  }

  Future<void> getContactDetailApi(dynamic body, BuildContext context) async {
    //loading(true);
    ContactDetailModel? model = await apiService.getContactDetail(body);
    loading(false);
    if (model!.status! && model!.code == 200) {
      contactDetail(model.body);
      contactDetail.refresh();
      // Get.toNamed(ContactDetailPage.routeName);
    } else {
      //  Get.toNamed(ContactDetailPage.routeName);
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(SnackBar(content: Text(model?.message ?? "")));
    }
  }
}
