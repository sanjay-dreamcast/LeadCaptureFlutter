class GuideModel {
  bool? status;
  int? code;
  String? message;
  Body? body;

  GuideModel({this.body,this.status, this.code, this.message});

  GuideModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    body = json['body'] != null ? new Body.fromJson(json['body']) : null;
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

class Body {
  Guides? guide;
  String? webview;
  bool? status;
  Body({this.guide,this.webview,this.status});

  Body.fromJson(Map<String, dynamic> json) {
    guide =
    json['guide'] != null ? new Guides.fromJson(json['guide']) : null;
    webview = json['webview'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.guide != null) {
      data['guide'] = this.guide!.toJson();
    }
    data['webview'] = this.webview;
    data['status'] = this.status;
    return data;
  }
}

class Guides {
  String? label;
  String? mediaUrl;
  String? mediaType;

  Guides(
      {
        this.label,
        this.mediaUrl,
        this.mediaType});

  Guides.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    mediaUrl = json['media_url'];
    mediaType = json['media_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['media_url'] = this.mediaUrl;
    data['media_type'] = this.mediaType;

    return data;
  }
}