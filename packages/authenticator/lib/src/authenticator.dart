import 'dart:async';
import 'dart:developer' show log;

import 'package:auth_client_interface/auth_client_interface.dart';
import 'package:rxdart/rxdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// {@template authenticator}
/// The implementation of authentication methods for various backends.
/// {@endtemplate}
class Authenticator implements AuthClientInterface {
  /// {@macro authenticator}
  Authenticator({
    required this.supabase,
  }) {
    initProcess();
  }

  /// An instance of [SupabaseClient] used for interacting with the
  ///  Supabase backend.
  final SupabaseClient supabase;

  // late StreamController<AuthUserModel> _userController;
  late final BehaviorSubject<AuthUserModel> _userController;

  /// Initializes the authentication process by setting up the user controller
  /// and listening for authentication state changes.
  ///
  /// This method creates a broadcast stream controller for `AuthUserModel` and
  /// listens to authentication state changes from Supabase. When the user signs
  /// in, the corresponding event is handled.
  void initProcess() {
    _userController =
        BehaviorSubject<AuthUserModel>.seeded(AuthUserModel.unauthenticated());

    supabase.auth.onAuthStateChange.listen((data) {
      final event = data.event;
      log('Auth event: $event');

      if (event == AuthChangeEvent.initialSession && data.session != null) {
        _userController.add(
          AuthUserModel(
            user: data.session!.user,
            userSession: data.session,
            authStatus: AuthStatus.authenticated,
          ),
        );
      } else if (event == AuthChangeEvent.signedIn && data.session != null) {
        _userController.add(
          AuthUserModel(
            user: data.session!.user,
            userSession: data.session,
            authStatus: AuthStatus.authenticated,
          ),
        );
      } else {
        _userController.add(AuthUserModel.unauthenticated());
      }
    });
  }

  @override
  Stream<AuthUserModel> get currentUserStream => _userController.stream;

  @override
  Future<void> logInWithEmail(EmailAndPasswordCredential credentials) async {
    final (email, password, _) = credentials;

    try {
      final res = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      final user = res.user!;
      _userController.add(
        AuthUserModel(
          user: user,
          authStatus: AuthStatus.authenticated,
          userSession: res.session,
        ),
      );
    } on AuthApiException catch (error, stackTrace) {
      log(
        '${error.statusCode}-${error.message}-${error.code}',
        name: 'Authenticator: loginWithEmail',
      );

      Error.throwWithStackTrace(
        LogInWithEmailFailure.fromCode(error.code!, error),
        stackTrace,
      );
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(
        LogInWithEmailFailure.unknown(error),
        stackTrace,
      );
    }
  }

  @override
  Future<void> logInWithGoogle() {
    // TODO: implement logInWithGoogle
    throw UnimplementedError();
  }

  @override
  Future<void> logOut() async {
    try {
      await supabase.auth.signOut();
      _userController.add(AuthUserModel.unauthenticated());
    } on AuthApiException catch (error, stackTrace) {
      log(
        'Error signing out: $error',
        name: 'Authenticator: logOut',
      );
      Error.throwWithStackTrace(LogOutFailure(error), stackTrace);
    }
  }

  @override
  Future<void> signUpWithEmail(EmailAndPasswordCredential credentials) async {
    final (email, password, metaData) = credentials;

    try {
      await supabase.auth.signUp(
        email: email,
        password: password,
        data: metaData,
      );
    } on AuthApiException catch (error, stackTrace) {
      log(
        '${error.statusCode}-${error.message}-${error.code}',
        name: 'Authenticator: loginWithEmail',
      );

      Error.throwWithStackTrace(
        RegisterWithEmailFailure.fromCode(error.code!, error),
        stackTrace,
      );
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(
        RegisterWithEmailFailure.unknown(error),
        stackTrace,
      );
    }
  }

  @override
  Future<void> signUpWithPhone(PhoneAndPasswordCredential credentials) async {
    final (phone, password) = credentials;
    try {
      await supabase.auth.signUp(
        phone: phone,
        password: password,
      );
    } on Exception catch (error, stackTrace) {
      log(
        'Error signing up with phone: $error',
        name: 'Authenticator: signUpWithPhone',
      );
      Error.throwWithStackTrace(RegisterWithPhoneFailure(error), stackTrace);
    }
  }

  @override

  /// Disposes of the resources used by the authenticator.
  ///
  /// This method should be called when the authenticator is no longer needed
  /// to release any resources it holds.
  void close() {
    _userController.close();
  }

  @override
  Future<void> verifyOTP(OTPVerificationCredential credentials) async {
    try {
      final (otp, email) = credentials;
      await supabase.auth.verifyOTP(
        type: OtpType.signup,
        token: otp,
        email: email,
      );
    } on AuthApiException catch (error, stackTrace) {
      log(
        'Error verifying OTP: ${error.message}, Error code: ${error.code}',
        stackTrace: stackTrace,
      );
      Error.throwWithStackTrace(
        OTPVerificationFailure.fromCode(error.code!, error),
        stackTrace,
      );
    } catch (e, stackTrace) {
      log('Error verifying OTP: $e', stackTrace: stackTrace);
      Error.throwWithStackTrace(OTPVerificationFailure.unknown(e), stackTrace);
    }
  }
}
