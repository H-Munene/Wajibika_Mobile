import 'package:bloc_clean_arch/core/core.dart';
import 'package:bloc_clean_arch/data/data.dart';
import 'package:bloc_clean_arch/data/data_sources/local_db_datasource.dart';
import 'package:bloc_clean_arch/data/data_sources/local_db_datasource_impl.dart';
import 'package:bloc_clean_arch/data/repositories/user_repository_impl.dart';
import 'package:bloc_clean_arch/domain/domain.dart';
import 'package:bloc_clean_arch/domain/repositories/user_repository.dart';
import 'package:bloc_clean_arch/domain/usecases/already_signed_in.dart';
import 'package:bloc_clean_arch/domain/usecases/signout_usecase_impl.dart';
import 'package:bloc_clean_arch/presentation/bloc/auth/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final locator = GetIt.instance;

Future<void> init() async {
  final supabase = await Supabase.initialize(
    url: SupabaseSecrets.url,
    anonKey: SupabaseSecrets.anonKey,
  );

  final sharedPreferences = await SharedPreferences.getInstance();

  locator
    ..registerLazySingleton(() => supabase.client)
    ..registerLazySingleton(() => sharedPreferences);

  _initAuth();
}

void _initAuth() {
  locator
    ..registerFactory<AuthDataSource>(
      () => AuthDataSourceImpl(supabaseClient: locator<SupabaseClient>()),
    )
    ..registerLazySingleton<LocalDbDataSource>(
      () => LocalDbDatasourceImpl(
        sharedPreferences: locator<SharedPreferences>(),
      ),
    )
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(authDatasource: locator()),
    )
    ..registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(localDbDataSource: locator()),
    )
    ..registerFactory(() => UserSignUpUseCase(authRepository: locator()))
    ..registerFactory(() => UserLoginUseCase(authRepository: locator()))
    ..registerFactory(() => SignOutUseCase(authRepository: locator()))
    ..registerFactory(() => AlreadySignedIn(authRepository: locator()))
    ..registerLazySingleton(
      () => AuthBloc(
        userSignUpUseCase: locator(),
        userLoginUseCase: locator(),
        signOutUseCase: locator(),
        alreadySignedIn: locator(),
        userRepository: locator(),
      ),
    );
}
