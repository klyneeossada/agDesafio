import 'dart:convert';

import 'package:flutter_app/models/password/password_message_response.dart';
import 'package:flutter_app/models/password/password_response.dart';
import 'package:http/http.dart' as http;

class PasswordRepository {
  Future<PasswordResponseV1> getPassword() async {
    final response = await http.get(
      Uri.parse('https://desafioflutter-api.modelviewlabs.com/random'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return PasswordResponseV1.fromJson(data);
    } else {
      throw Exception('Erro ao obter a senha: ${response.statusCode}');
    }
  }

  Future<PasswordMessageResponseV1> passwordValidate(String password) async {
    final response = await http.post(
        Uri.parse('https://desafioflutter-api.modelviewlabs.com/validate'),
        body: jsonEncode({'password': password}));

    final data = json.decode(response.body);
    return PasswordMessageResponseV1.fromJson(data);
  }
}
