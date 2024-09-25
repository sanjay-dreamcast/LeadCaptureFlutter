class UserModelModel {
  Body? body;
  bool? status;
  int? code;
  UserModelModel({this.status, this.code, this.body});

  UserModelModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    body = json['body'] != null ? new Body.fromJson(json['body']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['code'] = this.code;
    if (this.body != null) {
      data['body'] = this.body!.toJson();
    }
    return data;
  }
}

class Body {
  bool? status;
  Data? data;

  Body({this.status, this.data});

  Body.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  dynamic id;
  String? name;
  String? email;
  String? shortName;
  String? company;

  Data({this.id, this.name, this.email, this.shortName, this.company});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    shortName = json['short_name'];
    company = json['company'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['short_name'] = this.shortName;
    data['company'] = this.company;
    return data;
  }
}
