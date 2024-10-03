class BaseApiModel<T> {
  int? _statusCode;
  String? _message;
  bool? _status; // New boolean field
  T? _data; // Generic field for the body

  BaseApiModel(this._statusCode, this._message, this._status, this._data);

  // Getters
  int? get statusCode => _statusCode;
  String? get message => _message;
  bool? get status => _status; // Getter for the new field
  T? get data => _data; // Getter for the body

  // Updated factory constructor
  factory BaseApiModel.fromJson(Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJsonT) {
    return BaseApiModel(
      json["code"] as int?,
      json["message"] as String?,
      json["status"] as bool?, // Parse the new boolean field
      fromJsonT(json["body"] ?? {}), // Convert the JSON object in "body" to the specified type
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'code': _statusCode,
      'message': _message,
      'status': _status, // Include the new boolean field in the JSON output
      'body': _data, // Include the body field in the JSON output
    };
  }
}

