import 'package:app_preference_repository/app_preference_repository.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:brddge/app/app.dart';
import 'package:brddge/auth/auth.dart';
import 'package:brddge/design/design.dart';
import 'package:brddge/l10n/l10n.dart';
import 'package:brddge/router/router_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({
    required AuthenticationRepository authenticationRepository,
    required AppPreferenceRepository appPreferenceRepository,
    super.key,
  })  : _authenticationRepository = authenticationRepository,
        _appPreferenceRepository = appPreferenceRepository;

  final AuthenticationRepository _authenticationRepository;
  final AppPreferenceRepository _appPreferenceRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthenticationRepository>.value(
          value: _authenticationRepository,
        ),
        RepositoryProvider<AppPreferenceRepository>.value(
          value: _appPreferenceRepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            lazy: false, // Ensure immediate initialization
            create: (context) => AppBloc(
              context.read<AuthenticationRepository>(),
              context.read<AppPreferenceRepository>(),
            )..add(const AppOpened()),
          ),
          BlocProvider(
            lazy: false, // Ensure immediate initialization
            create: (context) => AuthenticationBloc(
              authenticationRepository:
                  context.read<AuthenticationRepository>(),
            ),
          ),
        ],
        child: const _AppProviders(),
      ),
    );
  }
}

/// Helper widget to avoid nesting providers in [App].
class _AppProviders extends StatelessWidget {
  const _AppProviders();

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<AppRouter>(
      // lazy: false, // Ensure immediate initialization
      create: (context) => AppRouter(context.read<AppBloc>()),
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: context.read<AppRouter>().router,
      debugShowCheckedModeBanner: false,
      theme: BrddgeTheme.theme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
