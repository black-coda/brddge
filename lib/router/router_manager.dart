/// The `AppRouter` class is responsible for managing the application's routing
/// using the `GoRouter` package. It defines the routes, handles redirection logic,
/// and listens to application state changes to refresh the router.
///
/// ### Key Features:
/// - **Dynamic Redirection**: Redirects users based on their authentication status
///   and onboarding requirements.
/// - **Route Definitions**: Provides a list of routes for the application, each
///   associated with a specific screen.
/// - **State Listening**: Uses `GoRouterRefreshStream` to listen to changes in
///   the `AppBloc` state and notify the router for updates.
///
/// ### Methods:
/// - `router(BuildContext context)`: Returns a configured `GoRouter` instance
///   with routes, redirection logic, and state refresh capabilities.
///
/// ### Routes:
/// - `LoginWithEmailScreen`: Path for the login screen.
/// - `RegisterWithEmailScreen`: Path for the registration screen.
/// - `DashboardScreen`: Path for the dashboard screen.
/// - `OTPScreen`: Path for the OTP verification screen.
/// - `OnboardScreen`: Path for the onboarding screen, with support for an
///   `initialPage` parameter.
///
/// ### Redirection Logic:
/// - Redirects unauthenticated users to the login screen.
/// - Redirects users who require onboarding to the onboarding screen, unless
///   they are already on it.
///
/// ### Supporting Classes:
/// - `GoRouterRefreshStream`: A helper class that listens to the `AppBloc`
///   state stream and notifies the router when the state changes, ensuring
///   the router stays in sync with the application state.
library;

import 'dart:developer';

import 'package:brddge/app/app.dart';
import 'package:brddge/auth/auth.dart';
import 'package:brddge/home/home.dart';
import 'package:brddge/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  AppRouter(this.appBloc) {
    router = GoRouter(
      initialLocation: OnboardScreen.initPath,
      debugLogDiagnostics: true,
      // Useful for debugging routes
      refreshListenable: GoRouterRefreshStream(appBloc.stream),
      redirect: _redirectLogic,
      routes: _buildRoutes(),
    );
  }

  late final GoRouter router;
  final AppBloc appBloc;

  /// Centralized redirect logic for cleaner separation
  String? _redirectLogic(BuildContext context, GoRouterState state) {
    final appBloc = context.read<AppBloc>();
    final currentPath = state.fullPath;
    final status = appBloc.state.status;

    log('App status: $status'); // Debug logging

    // Redirect to login if unauthenticated and not on an auth-related path
    if (status == AppStatus.unauthenticated &&
        !_isAuthRelatedPath(currentPath)) {
      return LoginWithEmailScreen.path;
    }

    // Redirect to onboarding if required and not already there
    if (status == AppStatus.onBoardingRequired &&
        currentPath != OnboardScreen.path) {
      return OnboardScreen.initPath;
    }

    // Redirect to dashboard if authenticated and not already there
    if (status == AppStatus.authenticated &&
        currentPath != DashboardScreen.path) {
      return DashboardScreen.path;
    }

    return null; // No redirect needed
  }

  /// Checks if the current path is auth-related (login, register, OTP, etc.)
  bool _isAuthRelatedPath(String? path) {
    return const [
      LoginWithEmailScreen.path,
      RegisterWithEmailScreen.path,
      OTPScreen.path,
      OnboardScreen.path,
    ].contains(path);
  }

  /// Builds all routes in a maintainable way
  List<GoRoute> _buildRoutes() {
    return [
      // Auth Routes
      _buildRoute(
        path: LoginWithEmailScreen.path,
        name: LoginWithEmailScreen.name,
        child: const LoginWithEmailScreen(),
      ),
      _buildRoute(
        path: RegisterWithEmailScreen.path,
        name: RegisterWithEmailScreen.name,
        child: const RegisterWithEmailScreen(),
      ),
      _buildRoute(
        path: OTPScreen.path,
        name: OTPScreen.name,
        child: const OTPScreen(),
      ),

      // Main App Routes
      _buildRoute(
        path: DashboardScreen.path,
        name: DashboardScreen.name,
        child: const DashboardScreen(),
      ),

      // Onboarding (dynamic parameter)
      GoRoute(
        path: OnboardScreen.path,
        name: OnboardScreen.name,
        pageBuilder: (context, state) {
          final initialPage = state.pathParameters['initialPage'] ?? '0';
          return BrddgeTransitionPage(
            child: OnboardScreen(initialPage: int.parse(initialPage)),
          );
        },
      ),
    ];
  }

  /// Helper to reduce boilerplate for simple routes
  GoRoute _buildRoute({
    required String path,
    required String name,
    required Widget child,
  }) {
    return GoRoute(
      path: path,
      name: name,
      pageBuilder: (_, state) => BrddgeTransitionPage(child: child),
    );
  }
}

/// Helper to refresh GoRouter when Bloc state changes
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<AppState> stream) {
    stream.listen((data) {
      log('App status: ${data.status}', name: 'GoRouterRefreshStream');
      notifyListeners(); // Notify GoRouter when state changes
    });
  }
}
