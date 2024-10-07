import 'LeadsData.dart';

class LeadsBodyData {
  List<LeadsData>? leads;
  bool? hasNextPage;

  // Constructor
  LeadsBodyData({
    this.leads,
    this.hasNextPage,
  });

  // fromJson method to parse JSON data
  factory LeadsBodyData.fromJson(Map<String, dynamic> json) {
    return LeadsBodyData(
      leads: json['leads'] != null
          ? (json['leads'] as List).map((e) => LeadsData.fromJson(e)).toList()
          : null,
      hasNextPage: json['hasNextPage'],
    );
  }

  // toJson method to convert object to JSON
  Map<String, dynamic> toJson() {
    return {
      'leads': leads?.map((e) => e.toJson()).toList(),
      'hasNextPage': hasNextPage,
    };
  }
}