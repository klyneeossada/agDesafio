import 'package:flutter/material.dart';
import 'package:flutter_app/controllers/password_controller.dart';
import 'package:flutter_app/models/password/password_message_response.dart';
import 'package:flutter_app/ui/successful_password_view.dart';
import 'package:provider/provider.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  late TextEditingController _passwordTextFieldController;

  @override
  void initState() {
    super.initState();
    final passwordController = context.read<PasswordController>();

    _passwordTextFieldController =
        TextEditingController(text: passwordController.password);

    _passwordTextFieldController.addListener(() {
      passwordController.updatePassword(_passwordTextFieldController.text);
    });
  }

  @override
  void dispose() {
    _passwordTextFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final passwordController = context.watch<PasswordController>();

    if (passwordController.password != _passwordTextFieldController.text) {
      _passwordTextFieldController.text = passwordController.password;
    }

    const defaultSize = 16.0;
    final obscurePassword = passwordController.obscurePassword;

    return Scaffold(
      appBar: AppBar(title: const Text('Senha')),
      body: Padding(
        padding: const EdgeInsets.all(defaultSize),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              obscureText: obscurePassword,
              controller: _passwordTextFieldController,
              decoration: InputDecoration(
                  labelText: 'Senha',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                      onPressed: () {
                        passwordController.setObscurePass(!obscurePassword);
                      },
                      icon: Icon(obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility))),
            ),
            const SizedBox(height: defaultSize),
            ElevatedButton(
              onPressed: passwordController.loadingState
                  ? null
                  : () async {
                      await passwordController.getPassword();
                    },
              child: passwordController.loadingState
                  ? const CircularProgressIndicator(
                      backgroundColor: Colors.blueAccent,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.cyan),
                    )
                  : const Text('Gerar uma senha'),
            ),
            const SizedBox(height: defaultSize),
            ElevatedButton(
              onPressed: passwordController.loadingState
                  ? null
                  : () async {
                      try {
                        final response =
                            await passwordController.passwordValidate(
                                _passwordTextFieldController.text);

                        if (!context.mounted) return;
                        if (response.id == null) {
                          _dialogBuilder(context, response);
                          return;
                        }

                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SuccessfulPassView(
                            message: response.message,
                          ),
                        ));
                      } catch (e) {
                        return showDialog<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Erro!'),
                              content: const Text(
                                  'Erro ao validar, por favor tente novamente'),
                              actions: [
                                TextButton(
                                  style: TextButton.styleFrom(
                                    textStyle:
                                        Theme.of(context).textTheme.labelLarge,
                                  ),
                                  child: const Text('Ok'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
              child: passwordController.loadingState
                  ? const CircularProgressIndicator(
                      backgroundColor: Colors.blueAccent,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.cyan),
                    )
                  : const Text('Validar'),
            ),
            const SizedBox(height: defaultSize),
          ],
        ),
      ),
    );
  }

  Future<void> _dialogBuilder(
      BuildContext context, PasswordMessageResponseV1 message) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(message.message),
          content: Text(message.errors?.join('-') ?? ''),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
