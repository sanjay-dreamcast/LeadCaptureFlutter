
class EmailErrorBody {
  final String? emailError; // Changed to nullable

  EmailErrorBody({required this.emailError});

  // Factory method to parse the error body from JSON
  factory EmailErrorBody.fromJson(Map<String, dynamic> json) {
    return EmailErrorBody(
      emailError: json['email'] as String?, // Changed to nullable
    );
  }
}
