import 'package:ap_project/screens/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'screens/accounts/accounts_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'پی بانک',
      home: const WelcomeScreen(),
    );
  }
}