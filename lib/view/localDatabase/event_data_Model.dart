
import 'dart:convert';

class EventApiResponse {
  final bool? status;
  final String? message;
  final List<EventData>? body;
  final int? code;

  EventApiResponse({this.status, this.message, this.body, this.code});

  factory EventApiResponse.fromJson(Map<String, dynamic> json) {
    return EventApiResponse(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      body: (json['body'] as List<dynamic>?)
          ?.map((event) => EventData.fromJson(event as Map<String, dynamic>))
          .toList(),
      code: json['code'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'body': body?.map((event) => event.toJson()).toList(),
      'code': code,
    };
  }
}

class EventData {
  final String? id;
  final String? name;
  final String? prefix;
  final String? type;
  final String? url;
  final String? startDatetime;
  final String? endDatetime;
  final String? location;
  final String? logoImage;
  final int? status;
  final String? created;
  final String? modified;
  final int? isSync;

  EventData({
    this.id,
    this.name,
    this.prefix,
    this.type,
    this.url,
    this.startDatetime,
    this.endDatetime,
    this.location,
    this.logoImage,
    this.status,
    this.created,
    this.modified,
    this.isSync,
  });

  factory EventData.fromJson(Map<String, dynamic> json) {
    return EventData(
      id: json['id'] as String?,
      name: json['name'] as String?,
      prefix: json['prefix'] as String?,
      type: json['type'] as String?,
      url: json['url'] as String?,
      startDatetime: json['start_datetime'] as String?,
      endDatetime: json['end_datetime'] as String?,
      location: json['location'] as String?,
      logoImage: json['logo_image'] as String?,
      status: json['status'] as int?,
      created: json['created'] as String?,
      modified: json['modified'] as String?,
      isSync: json['is_sync'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'prefix': prefix,
      'type': type,
      'url': url,
      'start_datetime': startDatetime,
      'end_datetime': endDatetime,
      'location': location,
      'logo_image': logoImage,
      'status': status,
      'created': created,
      'modified': modified,
      'is_sync': isSync,
    };
  }
}
