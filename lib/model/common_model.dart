class CommonModel {
  bool? status;
  int? code;
  String? message;

  CommonModel({this.status, this.code, this.message});

  CommonModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['code'] = this.code;
    data['message'] = this.message;
    return data;
  }
}
