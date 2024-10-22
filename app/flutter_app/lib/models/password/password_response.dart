class PasswordResponseV1 {
  final String? password;

  PasswordResponseV1({
    required this.password,
  });

  factory PasswordResponseV1.fromJson(Map<String, dynamic> json) {
    return PasswordResponseV1(
      password: json['password'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'password': password,
    };
  }
}
