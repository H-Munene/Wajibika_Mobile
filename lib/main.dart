import 'package:bloc_clean_arch/core/core.dart';
import 'package:bloc_clean_arch/data/data_sources/auth_datasource_impl.dart';
import 'package:bloc_clean_arch/data/repositories/auth_repository_impl.dart';
import 'package:bloc_clean_arch/domain/usecases/signup_usecase_impl.dart';
import 'package:bloc_clean_arch/presentation/bloc/auth_bloc.dart';
import 'package:bloc_clean_arch/presentation/pages/auth/pages.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final supabase = await Supabase.initialize(
    url: SupabaseSecrets.url,
    anonKey: SupabaseSecrets.anonKey,
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (_) => AuthBloc(
                userSignUpUseCase: UserSignUpUseCase(
                  authRepository: AuthRepositoryImpl(
                    authDatasource: AuthDatasourceImpl(
                      supabaseClient: supabase.client,
                    ),
                  ),
                ),
              ),
        ),
      ],
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
