import 'package:brddge/app/app.dart';
import 'package:brddge/auth/auth.dart';
import 'package:brddge/home/home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static GoRouter router() => GoRouter(
        initialLocation: LoginScreen.path,
        redirect: (context, state) {
          if (context.watch<AppBloc>().state.status ==
              AppStatus.authenticated) {
            return DashboardScreen.path;
          }
          return null;
        },
        routes: [
          GoRoute(
            path: LoginScreen.path,
            name: LoginScreen.name,
            builder: (context, state) => const LoginScreen(),
          ),
          GoRoute(
            path: DashboardScreen.path,
            name: DashboardScreen.name,
            builder: (context, state) => const DashboardScreen(),
          ),
        ],
      );
}
