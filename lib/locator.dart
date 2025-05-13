import 'package:bloc_clean_arch/core/core.dart';
import 'package:bloc_clean_arch/data/data.dart';
import 'package:bloc_clean_arch/domain/domain.dart';
import 'package:bloc_clean_arch/domain/usecases/signout_usecase_impl.dart';

import 'package:bloc_clean_arch/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final locator = GetIt.instance;

Future<void> init() async {
  _initAuth();

  final supabase = await Supabase.initialize(
    url: SupabaseSecrets.url,
    anonKey: SupabaseSecrets.anonKey,
  );

  locator.registerLazySingleton(() => supabase.client);
}

void _initAuth() {
  locator
    ..registerFactory<AuthDataSource>(
      () => AuthDataSourceImpl(supabaseClient: locator<SupabaseClient>()),
    )
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(authDatasource: locator()),
    )
    ..registerFactory(() => UserSignUpUseCase(authRepository: locator()))
    ..registerFactory(() => UserLoginUseCase(authRepository: locator()))
    ..registerFactory(() => SignOutUseCase(authRepository: locator()))
    ..registerLazySingleton(
      () => AuthBloc(
        userSignUpUseCase: locator(),
        userLoginUseCase: locator(),
        signOutUseCase: locator(),
      ),
    );
}
