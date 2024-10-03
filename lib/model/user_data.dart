class UserData {
  final String? _name;
  final String? _id;
  final String? _shortName;
  final String? _company;
  final String? _position;
  final String? _avatar;
  final String? _verificationCode;
  final String? _token;
  final String? _accessToken;
  final int? _syncLimit;

  UserData({
    String? name,
    String? id,
    String? shortName,
    String? company,
    String? position,
    String? avatar,
    String? verificationCode,
    String? token,
    String? accessToken,
    int? syncLimit,
  })  : _name = name,
        _id = id,
        _shortName = shortName,
        _company = company,
        _position = position,
        _avatar = avatar,
        _verificationCode = verificationCode,
        _token = token,
        _accessToken = accessToken,
        _syncLimit = syncLimit;

  // Getters
  String? get name => _name;
  String? get id => _id;
  String? get shortName => _shortName;
  String? get company => _company;
  String? get position => _position;
  String? get avatar => _avatar;
  String? get verificationCode => _verificationCode;
  String? get token => _token;
  String? get accessToken => _accessToken;
  int? get syncLimit => _syncLimit;

  // Factory method to create an instance from JSON
  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      name: json['name'] as String?,
      id: json['id'] as String?,
      shortName: json['short_name'] as String?,
      company: json['company'] as String?,
      position: json['position'] as String?,
      avatar: json['avatar'] as String?,
      verificationCode: json['verification_code'] as String?,
      token: json['token'] as String?,
      accessToken: json['access_token'] as String?,
      syncLimit: json['sync_limit'] as int?,
    );
  }

  // Method to convert the instance back to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': _name,
      'id': _id,
      'short_name': _shortName,
      'company': _company,
      'position': _position,
      'avatar': _avatar,
      'verification_code': _verificationCode,
      'token': _token,
      'access_token': _accessToken,
      'sync_limit': _syncLimit,
    };
  }
}
