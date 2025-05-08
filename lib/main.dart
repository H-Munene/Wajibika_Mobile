import 'package:bloc_clean_arch/core/core.dart';
import 'package:bloc_clean_arch/presentation/pages/auth/signup.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bloc Clean Arch',
      theme: AppTheme.lightTheme(),

      home: const SignUpPage(),
    );
  }
}
