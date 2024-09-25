class BadgeModel {
  bool? status;
  int? code;
  Body? body;

  BadgeModel({this.status, this.code, this.body});

  BadgeModel.fromJson(Map<String, dynamic> json) {
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
  String? badgeUrl;
  String? message;
  Body({this.badgeUrl,this.message});

  Body.fromJson(Map<String, dynamic> json) {
    badgeUrl = json['badge'];
    message=json ['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['badge'] = this.badgeUrl;
    data['message'] = this.message;
    return data;
  }
}
