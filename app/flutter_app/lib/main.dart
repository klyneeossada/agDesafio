import 'package:flutter/material.dart';
import 'package:flutter_app/controllers/password_controller.dart';
import 'package:flutter_app/my_app.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PasswordController()),
      ],
      child: const MyApp(),
    ),
  );
}
