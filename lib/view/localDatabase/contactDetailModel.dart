class ContactDetailModel {
  bool? status;
  int? code;
  String? message;
  ContactDetail? body;

  ContactDetailModel({this.status, this.code, this.message, this.body});

  ContactDetailModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    body =
        json['body'] != null ? new ContactDetail.fromJson(json['body']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.body != null) {
      data['body'] = this.body!.toJson();
    }
    return data;
  }
}

class ContactDetail {
  bool? status;
  Data? data;

  ContactDetail({this.status, this.data});

  ContactDetail.fromJson(Map<String, dynamic> json) {
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
  String? id;
  String? name;
  String? shortName;
  String? avatar;
  String? company;
  String? position;
  String? email;
  String? countryCode;
  String? mobile;
  String? linkedin;
  String? facebook;
  String? twitter;
  String? instagram;
  String? youtube;
  String? google;
  String? website;
  String? description;
  String? note;

  Data(
      {
        this.id,
        this.name,
      this.shortName,
      this.avatar,
      this.company,
      this.position,
      this.email,
      this.countryCode,
      this.mobile,
      this.linkedin,
      this.facebook,
      this.twitter,
      this.instagram,
      this.youtube,
      this.google,
      this.website,
      this.description, this.note});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    shortName = json['short_name'];
    avatar = json['avatar'];
    company = json['company'];
    position = json['position'];
    email = json['email'];
    countryCode = json['country_code'];
    mobile = json['mobile'];
    linkedin = json['linkedin'];
    facebook = json['facebook'];
    twitter = json['twitter'];
    instagram = json['instagram'];
    youtube = json['youtube'];
    google = json['google'];
    website = json['website'];
    description = json['description'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['short_name'] = this.shortName;
    data['avatar'] = this.avatar;
    data['company'] = this.company;
    data['position'] = this.position;
    data['email'] = this.email;
    data['country_code'] = this.countryCode;
    data['mobile'] = this.mobile;
    data['linkedin'] = this.linkedin;
    data['facebook'] = this.facebook;
    data['twitter'] = this.twitter;
    data['instagram'] = this.instagram;
    data['youtube'] = this.youtube;
    data['google'] = this.google;
    data['website'] = this.website;
    data['description'] = this.description;
    data['note'] = this.note;
    return data;
  }
}
