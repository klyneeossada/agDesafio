import 'package:flutter/material.dart';

class SuccessfulPassView extends StatelessWidget {
  const SuccessfulPassView({required this.message, super.key});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tela do sucesso!'),
      ),
      body: Center(
        child: AlertDialog(
          title: const Text('Sucesso!'),
          content: Text(message),
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
        ),
      ),
    );
  }
}
