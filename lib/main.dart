import 'package:flutter/material.dart';
import 'package:bloc_clean_arch/bloc_observer.dart';
import 'package:bloc_clean_arch/core/core.dart';
import 'package:bloc_clean_arch/dependencies.dart';
import 'package:bloc_clean_arch/domain/domain.dart';
import 'package:bloc_clean_arch/presentation/presentation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  Bloc.observer = AppBlocObserver();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory:
        kIsWeb
            ? HydratedStorageDirectory.web
            : HydratedStorageDirectory((await getTemporaryDirectory()).path),
  );

  await init();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (_) => locator<UserRepository>(),
          dispose: (repo) => repo.deleteSavedUserDetails(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => locator<AuthBloc>()),
          BlocProvider(create: (_) => MediaBloc()),
          BlocProvider(create: (_) => ProfileMediaBloc()),
        ],

        child: const MyApp(),
      ),
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
    context.read<AuthBloc>().add(AuthCheckUserAlreadySignedIn());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final doNotShowOnboardingScreen =
        context.read<UserRepository>().doNotshowOnboardingScreen();

    return MaterialApp(
      title: 'Bloc Clean Arch',
      theme: AppTheme.lightTheme(),
      debugShowCheckedModeBanner: false,
      home: const ReportVolunteerHistoryPage(type: 'report'),

      // doNotShowOnboardingScreen
      //     ? const AuthWrapper()
      //     : const OnboardingScreen(),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoggedIn) {
          Navigator.of(context).pushReplacement(
            PageRouteBuilder(
              pageBuilder: (_, __, ___) => const BottomNav(),
              transitionDuration: Duration.zero,
            ),
          );
        } else {
          Navigator.of(context).pushReplacement(
            PageRouteBuilder(
              pageBuilder: (_, __, ___) => const LoginPage(),
              transitionDuration: Duration.zero,
            ),
          );
        }
      },
      child: const Scaffold(body: Center(child: CustomLoadingIndicator())),
    );
  }
}
