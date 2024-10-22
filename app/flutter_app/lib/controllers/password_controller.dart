import 'package:flutter/material.dart';
import 'package:flutter_app/models/password/password_message_response.dart';
import 'package:flutter_app/repositories/password_repository.dart';

class PasswordController extends ChangeNotifier {
  var _loadingState = false;
  bool get loadingState => _loadingState;

  var _password = '';
  String get password => _password;

  var _obscurePassword = false;
  bool get obscurePassword => _obscurePassword;

  void updatePassword(String value) {
    _password = value;
    notifyListeners();
  }

  void setObscurePass(bool value) {
    _obscurePassword = value;
    notifyListeners();
  }

  void setLoading(bool value) {
    _loadingState = value;
    notifyListeners();
  }

  Future<String> getPassword() async {
    try {
      setLoading(true);

      final response = await PasswordRepository().getPassword();

      if (response.password == null) {
        return 'Ocorreu um erro ao gerar a senha: Null Password';
      }

      _password = response.password!;
      notifyListeners();
      return _password;
    } catch (e) {
      setLoading(false);
      return e.toString();
    } finally {
      setLoading(false);
    }
  }

  Future<PasswordMessageResponseV1> passwordValidate(String password) async {
    try {
      setLoading(true);

      final response = await PasswordRepository().passwordValidate(password);

      notifyListeners();
      return response;
    } catch (e) {
      setLoading(false);

      rethrow;
    } finally {
      setLoading(false);
    }
  }
}
