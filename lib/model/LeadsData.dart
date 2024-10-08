


class LeadsData {
  String? id;
  String? userId;
  String? eventId;
  String? qrCode;
  String? name;
  String? email;
  String? countryCode;
  String? mobile;
  String? avatar;
  String? website;
  String? company;
  String? position;
  String? note;
  String? captureDatetime;
  int? isDeleted;
  String? deletedBy;
  String? created;
  String? modified;
  String? eventName;

  // Constructor
  LeadsData({
    this.id,
    this.userId,
    this.eventId,
    this.qrCode,
    this.name,
    this.email,
    this.countryCode,
    this.mobile,
    this.avatar,
    this.website,
    this.company,
    this.position,
    this.note,
    this.captureDatetime,
    this.isDeleted,
    this.deletedBy,
    this.created,
    this.modified,
    this.eventName,
  });

  // fromJson method to parse JSON data
  factory LeadsData.fromJson(Map<String, dynamic> json) {
    return LeadsData(
      id: json['id'],
      userId: json['user_id'],
      eventId: json['event_id'],
      qrCode: json['qrcode'],
      name: json['name'],
      email: json['email'],
      countryCode: json['country_code'],
      mobile: json['mobile'],
      avatar: json['avatar'],
      website: json['website'],
      company: json['company'],
      position: json['position'],
      note: json['note'],
      captureDatetime: json['capture_datetime'],
      isDeleted: json['is_deleted'],
      deletedBy: json['deleted_by'],
      created: json['created'],
      modified: json['modified'],
      eventName: json['event_name'],
    );
  }

  // toJson method to convert object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'event_id': eventId,
      'qrcode': qrCode,
      'name': name,
      'email': email,
      'country_code': countryCode,
      'mobile': mobile,
      'avatar': avatar,
      "website":website,
      'company': company,
      'position': position,
      'note': note,
      'capture_datetime': captureDatetime,
      'is_deleted': isDeleted,
      'deleted_by': deletedBy,
      'created': created,
      'modified': modified,
      'event_name': eventName,
    };
  }

  // Getters for each property
  String? get getId => id;
  String? get getUserId => userId;
  String? get getEventId => eventId;
  String? get getQrCode => qrCode;
  String? get getName => name;
  String? get getEmail => email;
  String? get getCountryCode => countryCode;
  String? get getMobile => mobile;
  String? get getAvatar => avatar;
  String? get getCompany => company;
  String? get getPosition => position;
  String? get getNote => note;
  String? get getCaptureDatetime => captureDatetime;
  int? get getIsDeleted => isDeleted;
  String? get getDeletedBy => deletedBy;
  String? get getCreated => created;
  String? get getModified => modified;
  String? get getEventName => eventName;
}



