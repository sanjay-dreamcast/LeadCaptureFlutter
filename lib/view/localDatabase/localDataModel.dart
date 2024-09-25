class LocalUser {
  final String id;
  final String name;
  final String email;
  final String mobile;
  final String company;
  final String title;
  final String website;

  const LocalUser({
    required this.id,
    required this.name,
    required this.email,
    required this.mobile,
    required this.company,
    required this.title,
    required this.website,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'mobile': mobile,
      'company': company,
      'title': title,
      'website': website,
    };
  }

  @override
  String toString() {
    return 'LocalUser{id: $id, name: $name, email: $email,mobile: $mobile, company: $company, title: $title,website: $website}';
  }
}
