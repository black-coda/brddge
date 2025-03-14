import 'package:authentication_repository/authentication_repository.dart';
import 'package:authenticator/authenticator.dart';
import 'package:brddge/app/app.dart';
import 'package:brddge/bootstrap.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
    await Supabase.initialize(
    url: 'https://mqfayfvwmubdywasltiy.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1xZmF5ZnZ3bXViZHl3YXNsdGl5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDE5MTIyMDAsImV4cCI6MjA1NzQ4ODIwMH0.JB5obXQu3OKgJrgRwgAYu5tjgpuZjw8E6j1qadThYJw',
  );

  final supabse = Supabase.instance.client;
  final authenticator = Authenticator(
    supabase: supabse,
  );
  final authenticationRepository =
      AuthenticationRepository(authClientInterface: authenticator);
  await bootstrap(
    () => App(
      authenticationRepository: authenticationRepository,
    ),
  );
}
