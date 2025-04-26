import 'package:app_preference_repository/app_preference_repository.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:authenticator/authenticator.dart';
import 'package:brddge/app/app.dart';
import 'package:brddge/bootstrap.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart' show WidgetsFlutterBinding;
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorageDirectory.web
        : HydratedStorageDirectory((await getTemporaryDirectory()).path),
  );
  await Supabase.initialize(
    url: 'https://mqfayfvwmubdywasltiy.supabase.co',
    anonKey:
        // ignore: lines_longer_than_80_chars
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1xZmF5ZnZ3bXViZHl3YXNsdGl5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDE5MTIyMDAsImV4cCI6MjA1NzQ4ODIwMH0.JB5obXQu3OKgJrgRwgAYu5tjgpuZjw8E6j1qadThYJw',
  );

  final sharedPref = SharedPreferences.getInstance();

  final supabase = Supabase.instance.client;
  final authenticator = Authenticator(
    supabase: supabase,
  );
  final authenticationRepository =
      AuthenticationRepository(authClientInterface: authenticator);
  final appPreferenceRepository = AppPreferenceRepository(
    preferences: await sharedPref,
    supabaseClient: supabase,
  );

  await bootstrap(
    () => App(
      authenticationRepository: authenticationRepository,
      appPreferenceRepository: appPreferenceRepository,
    ),
  );
}
