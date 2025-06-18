import 'package:bloc_clean_arch/core/core.dart';
import 'package:bloc_clean_arch/data/data.dart';
import 'package:bloc_clean_arch/domain/domain.dart';
import 'package:bloc_clean_arch/presentation/presentation.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final locator = GetIt.instance;

Future<void> init() async {
  // final supabase = await Supabase.initialize(
  //   url: SupabaseSecrets.url,
  //   anonKey: SupabaseSecrets.anonKey,
  // );

  final sharedPreferences = await SharedPreferences.getInstance();

  locator
    // ..registerLazySingleton(() => supabase.client)
    .registerLazySingleton(() => sharedPreferences);

  _initAuth();
}

void _initAuth() {
  locator
    ..registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(localDbDataSource: locator()),
    )
    ..registerLazySingleton<LocalDbDataSource>(
      () => LocalDbDatasourceImpl(
        sharedPreferences: locator<SharedPreferences>(),
      ),
    )
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(authDatasource: locator()),
    )
    ..registerFactory<AuthDataSource>(
      // () => SupabaseDataSourceImpl(supabaseClient: locator<SupabaseClient>()),
      () => LocahostDatasourceImpl(userRepository: locator()),
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
