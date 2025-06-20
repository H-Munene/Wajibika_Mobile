import 'package:bloc_clean_arch/data/data.dart';
import 'package:bloc_clean_arch/domain/domain.dart';
import 'package:bloc_clean_arch/presentation/bloc/home_feed/home_feed_bloc.dart';
import 'package:bloc_clean_arch/presentation/presentation.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    ..registerFactory<LocalHostAuthRepository>(
      () => LocalHostAuthRepositoryImpl(authDatasource: locator()),
    )
    ..registerFactory<LocalHostAuthDataSource>(
      //() => SupabaseDataSourceImpl(supabaseClient: locator<SupabaseClient>()),
      () => LocahostDatasourceImpl(userRepository: locator()),
    )
    ..registerFactory(
      () => UserSignUpUseCase(localHostAuthRepository: locator()),
    )
    ..registerFactory(
      () => UserLoginUseCase(localHostAuthRepository: locator()),
    )
    ..registerFactory(
      () => GetHomeFeedUseCase(localHostAuthRepository: locator()),
    )
    ..registerFactory(() => SignOutUseCase(localHostAuthRepository: locator()))
    ..registerFactory(() => AlreadySignedIn(localHostAuthRepository: locator()))
    ..registerLazySingleton(
      () => AuthBloc(
        userSignUpUseCase: locator(),
        userLoginUseCase: locator(),
        signOutUseCase: locator(),
        alreadySignedIn: locator(),
        userRepository: locator(),
      ),
    )
    ..registerFactory(() => HomeFeedBloc(getHomeFeedUseCase: locator()));
}
