import 'package:bloc_clean_arch/bloc_observer.dart';
import 'package:bloc_clean_arch/core/core.dart';
import 'package:bloc_clean_arch/locator.dart';
import 'package:bloc_clean_arch/presentation/bloc/auth_bloc.dart';
import 'package:bloc_clean_arch/presentation/pages/auth/pages.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';

void main() async {
  Bloc.observer = AppBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();

  await init();

  runApp(
    MultiBlocProvider(
      providers: [BlocProvider(create: (_) => locator<AuthBloc>())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    context.read<AuthBloc>().add(AuthUserAlreadySignedIn());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bloc Clean Arch',
      theme: AppTheme.lightTheme(),

      home: BlocSelector<AuthBloc, AuthState, bool>(
        selector: (state) {
          return state is AuthSuccess;
        },
        builder: (context, isLoggedIn) {
          if (isLoggedIn) {
            return const HomePage();
          } else {
            return const LoginPage();
          }
        },
      ),
    );
  }
}
