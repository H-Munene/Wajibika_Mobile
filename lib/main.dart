import 'package:bloc_clean_arch/core/core.dart';
import 'package:bloc_clean_arch/locator.dart';
import 'package:bloc_clean_arch/presentation/bloc/auth_bloc.dart';
import 'package:bloc_clean_arch/presentation/pages/auth/pages.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await init();

  runApp(
    MultiBlocProvider(
      providers: [BlocProvider(create: (_) => locator<AuthBloc>())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bloc Clean Arch',
      theme: AppTheme.lightTheme(),

      home: const LoginPage(),
    );
  }
}
