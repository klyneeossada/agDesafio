class PasswordMessageResponseV1 {
  final String? id;
  final String message;
  final List<String>? errors;

  PasswordMessageResponseV1({
    required this.message,
    this.id,
    this.errors,
  });

  factory PasswordMessageResponseV1.fromJson(Map<String, dynamic> json) {
    return PasswordMessageResponseV1(
      id: json['id'] as String?,
      message: json['message'] as String,
      errors:
          (json['errors'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );
  }
}
