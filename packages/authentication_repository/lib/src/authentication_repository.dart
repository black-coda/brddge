import 'package:auth_client_interface/auth_client_interface.dart';

/// {@template authentication_repository}
/// Authentication Repository
/// {@endtemplate}
class AuthenticationRepository {
  /// {@macro authentication_repository}
  const AuthenticationRepository({
    required AuthClientInterface authClientInterface,
  }) : _authClientInterface = authClientInterface;

  final AuthClientInterface _authClientInterface;

  /// Stream of [AuthUserModel] which will emit the current user when the
  /// authentication state changes.

  Stream<AuthUserModel> get currentUserStream =>
      _authClientInterface.currentUserStream;

  /// Sign in with email and password.
  ///
  /// Throws an [Exception] if the sign in fails.
  ///
  /// Returns a [Future] that completes with the current user when the sign in
  /// is successful.
  Future<void> logInWithEmail(EmailAndPasswordCredential credentials) async =>
      _authClientInterface.logInWithEmail(credentials);

  /// Sign out the current user.
  ///
  /// Throws an [Exception] if the sign out fails.
  Future<void> logOut() async => _authClientInterface.logOut();

  /// Sign up with email and password.
  ///
  /// Throws an [Exception] if the sign up fails.
  Future<void> signUpWithEmail(EmailAndPasswordCredential credentials) async =>
      _authClientInterface.signUpWithEmail(credentials);

  /// Sign in with Google.
  ///
  /// Throws an [Exception] if the sign in fails.
  Future<void> logInWithGoogle() async =>
      _authClientInterface.logInWithGoogle();

  /// Sign up with using phone number and password credentials.
  ///
  /// Throws an [Exception] if the sign in fails.
  Future<void> logInWithPhoneAndPassword(
    PhoneAndPasswordCredential credentials,
  ) async =>
      _authClientInterface.signUpWithPhone(credentials);

  /// OTP verification after registration
  ///
  /// Throws an [Exception] if the verification fails.
  Future<void> verifyOTP(OTPVerificationCredential credentials) async =>
      _authClientInterface.verifyOTP(credentials);

  /// close
  void close() {
    _authClientInterface.close();
  }
}
