import 'package:auth_client_interface/auth_client_interface.dart';

/// {@template authentication_exception}
/// Exceptions from the authentication client.
/// {@endtemplate}
abstract class AuthenticationException implements Exception {
  /// {@macro authentication_exception}
  const AuthenticationException(this.error);

  /// The error which was caught.
  final Object error;
}

/// {@template log_in_with_email_failure}
/// Thrown during the sign in with email process if a failure occurs.
/// {@endtemplate}
class LogInWithEmailFailure extends AuthenticationException {
  /// {@macro log_in_with_email_link_failure}
  const LogInWithEmailFailure(super.error);
}

/// Exception thrown when a registration with email fails.
///
/// This exception is thrown when there is an error during the registration
/// process using an email address.
class RegisterWithEmailFailure extends AuthenticationException {
  /// Represents a failure that occurs during the registration process with email.
  ///
  /// This class extends a base error class and provides additional context
  /// for errors specifically related to email registration.
  ///
  /// [error] is the error message or object that describes the failure.
  const RegisterWithEmailFailure(super.error);
}

/// Exception thrown when a registration with phone fails.
///
/// This exception is thrown when there is an error during the registration
/// process using a phone number.
class RegisterWithPhoneFailure extends AuthenticationException {
  const RegisterWithPhoneFailure(super.error);
}

/// {@template log_in_with_google_failure}
/// Thrown during the sign in with google process if a failure occurs.
/// {@endtemplate}
class LogInWithGoogleFailure extends AuthenticationException {
  /// {@macro log_in_with_google_failure}
  const LogInWithGoogleFailure(super.error);
}

/// {@template log_in_with_google_canceled}
/// Thrown during the sign in with google process if it's canceled.
/// {@endtemplate}
class LogInWithGoogleCanceled extends AuthenticationException {
  /// {@macro log_in_with_google_canceled}
  const LogInWithGoogleCanceled(super.error);
}

/// {@template log_out_failure}
/// Thrown during the logout process if a failure occurs.
/// {@endtemplate}
class LogOutFailure extends AuthenticationException {
  /// {@macro log_out_failure}
  const LogOutFailure(super.error);
}

/// {@template auth_client_interface}
/// The interface and models for an authentication API.
/// {@endtemplate}
abstract class AuthClientInterface {
  /// {@macro auth_client_interface}
  const AuthClientInterface();

  /// Stream of [AuthUserModel] which will emit the current user when
  /// the authentication state changes.
  ///
  /// Emits [AuthUserModel.unauthenticated()] if the user is not authenticated.
  Stream<AuthUserModel> get currentUserStream;

  /// Starts the Sign In with Google Flow.
  ///
  /// Throws a [LogInWithGoogleFailure] if an exception occurs.
  Future<void> logInWithGoogle();

  /// Signs out the current user which will emit
  /// [AuthUserModel.unauthenticated()] from the [currentUserStream] Stream.
  ///
  /// Throws a [LogOutFailure] if an exception occurs.
  Future<void> logOut();

  /// Logs in a user using email and password credentials.
  ///
  /// Takes an [EmailAndPasswordCredential] object as a parameter.
  ///
  /// Throws an [AuthenticationException] if the login fails.
  Future<void> logInWithEmail(EmailAndPasswordCredential credentials);

  /// Signs up a new user using email and password credentials.
  ///
  /// Takes an [EmailAndPasswordCredential] object as a parameter.
  ///
  /// Throws an [AuthenticationException] if the sign-up fails.
  Future<void> signUpWithEmail(EmailAndPasswordCredential credentials);

  /// Signs up a new user using phone number and password credentials.
  ///
  /// Takes a [PhoneAndPasswordCredential] object as a parameter.
  ///
  /// Throws an [AuthenticationException] if the sign-up fails.
  Future<void> signUpWithPhone(PhoneAndPasswordCredential credentials);

  /// dispose the stream used
  ///
  void close();
}
