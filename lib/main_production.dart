import 'package:authentication_repository/authentication_repository.dart';
import 'package:authenticator/authenticator.dart';
import 'package:brddge/app/app.dart';
import 'package:brddge/bootstrap.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await Supabase.initialize(
    url: 'https://xyzcompany.supabase.co',
    anonKey: 'public-anon-key',
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
