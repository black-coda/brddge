import 'package:auth_client_interface/auth_client_interface.dart';

/// {@template authentication_exception}
/// Exceptions from the authentication client.
/// {@endtemplate}
abstract class AuthenticationException implements Exception {
  /// {@macro authentication_exception}
  const AuthenticationException(this.error, {this.errorMsg = ''});

  /// The error which was caught.
  final Object error;

  /// The error message
  final String errorMsg;
}

/// {@template log_in_with_email_failure}
/// Thrown during the sign in with email process if a failure occurs.
/// {@endtemplate}
class LogInWithEmailFailure extends AuthenticationException {
  /// {@macro log_in_with_email_link_failure}
  const LogInWithEmailFailure(super.error, {super.errorMsg});

  /// Creates a `LogInWithEmailFailure` instance for an unknown error.
  ///
  /// This factory constructor is used when the specific cause of the error
  /// is not identified. The [error] parameter provides additional details
  /// about the unknown error.
  factory LogInWithEmailFailure.unknown(Object error) {
    return LogInWithEmailFailure(
      error,
      errorMsg: 'Unknown Error: Try again later or contact support.😔',
    );
  }

  /// Create an authentication message
  /// from a firebase authentication exception code.
  factory LogInWithEmailFailure.fromCode(String code, Object error) {
    switch (code) {
      case 'invalid_credentials':
        return LogInWithEmailFailure(
          error,
          errorMsg: 'Invalid email or password. Please try again.',
        );

      case 'user_not_found':
        return LogInWithEmailFailure(
          error,
          errorMsg: 'Email is not found, please create an account.',
        );

      default:
        return LogInWithEmailFailure.unknown(error);
    }
  }
}

/// Exception thrown when otp verification fails.
///
/// This exception is thrown when there is an error during the otp verification
/// process.
class OTPVerificationFailure extends AuthenticationException {
  /// Represents a failure that occurs
  /// during the otp verification process.
  ///
  /// This class extends a base error class and provides additional context
  /// for errors specifically related to otp verification.
  ///
  /// [error] is the error message or object that describes the failure.
  const OTPVerificationFailure(super.error, {super.errorMsg});

  /// Factory constructor for creating a [OTPVerificationFailure] instance
  /// based on a specific error code.
  ///
  /// Takes a [String] [code] and an [Object] [error] as parameters.
  ///
  /// The [code] parameter is used to determine the specific type of error
  /// that occurred during the OTP verification process.
  ///
  /// The [error] parameter provides additional details about the error.
  ///
  /// Returns an [OTPVerificationFailure] instance with a corresponding
  /// error message based on the provided [code].
  ///
  /// If the [code] does not match any known error codes, an unknown error
  /// message is returned.
  factory OTPVerificationFailure.fromCode(String code, Object error) {
    switch (code) {
      case 'otp_expired':
        return OTPVerificationFailure(
          error,
          errorMsg:
              'Invalid OTP or OTP code has expired. Please request a new one.',
        );
      case 'otp_disabled':
        return OTPVerificationFailure(
          error,
          errorMsg: 'OTP verification is disabled for this user.',
        );
      case 'over_email_send_rate_limit':
        return OTPVerificationFailure(
          error,
          errorMsg: 'Email send rate limit exceeded. Please try again later.',
        );
      default:
        return OTPVerificationFailure.unknown(error);
    }
  }

  /// Factory constructor for creating a [OTPVerificationFailure] instance
  /// when the error cause is unknown.
  ///
  /// Takes an [Object] [error] as a parameter, which represents the error
  /// that occurred.
  factory OTPVerificationFailure.unknown(Object error) {
    return OTPVerificationFailure(
      error,
      errorMsg: 'Unknown Error',
    );
  }
}

/// Exception thrown when a registration with email fails.
///
/// This exception is thrown when there is an error during the registration
/// process using an email address.
class RegisterWithEmailFailure extends AuthenticationException {
  /// Represents a failure that occurs
  /// during the registration process with email.
  ///
  /// This class extends a base error class and provides additional context
  /// for errors specifically related to email registration.
  ///
  /// [error] is the error message or object that describes the failure.
  const RegisterWithEmailFailure(super.error, {super.errorMsg});

  /// Create an authentication message
  /// from a firebase authentication exception code.
  /// https://pub.dev/documentation/firebase_auth/latest/firebase_auth/FirebaseAuth/createUserWithEmailAndPassword.html
  factory RegisterWithEmailFailure.fromCode(String code, Object error) {
    switch (code) {
      case 'email_exists':
        return RegisterWithEmailFailure(
          error,
          errorMsg: 'Email address already exists in the system',
        );
      case 'email_not_confirmed':
        return RegisterWithEmailFailure(
          error,
          errorMsg:
              'Signing in is not allowed for this user as the email address is'
              ' not confirmed.',
        );
      default:
        return RegisterWithEmailFailure.unknown(error);
    }
  }

  /// Factory constructor for creating a [RegisterWithEmailFailure] instance
  /// when the error cause is unknown.
  ///
  /// Takes an [Object] [error] as a parameter, which represents the error
  /// that occurred.
  factory RegisterWithEmailFailure.unknown(Object error) {
    return RegisterWithEmailFailure(
      error,
      errorMsg: 'Unknown Error',
    );
  }
}

/// Exception thrown when a registration with phone fails.
///
/// This exception is thrown when there is an error during the registration
/// process using a phone number.
class RegisterWithPhoneFailure extends AuthenticationException {
  /// Represents a failure that occurs
  /// during the registration process with phone number.
  ///
  /// This class extends a base error class and provides additional context
  /// for errors specifically related to phone number registration.
  ///
  /// [error] is the error message or object that describes the failure
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

  /// OTP Verification after registration
  ///
  /// Takes a [OTPVerificationCredential] object as a parameter.
  ///
  /// Throws an [AuthenticationException] if the verification fails.
  Future<void> verifyOTP(OTPVerificationCredential credentials);

  /// dispose the stream used
  ///
  void close();
}
