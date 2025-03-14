import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart' show Session, User;

/// Represents the authentication status of a user.
enum AuthStatus {
  /// The user is authenticated.
  authenticated,

  /// The user is not authenticated.
  unauthenticated,

  /// The user is not verified.
  hasVerificationPending
}

/// A model representing an authenticated user.
///
/// This class extends [Equatable] to provide value equality.
/// Represents an authenticated user.
class AuthUserModel extends Equatable {
  /// Creates an authenticated user instance.
  const AuthUserModel({
    required this.user,
    this.userSession,
    this.authStatus = AuthStatus.unauthenticated,
  });

  /// Creates an unauthenticated user instance.
  ///
  /// This is a factory constructor that creates an instance of [AuthUserModel]
  /// with the user and userSession set to null.
  factory AuthUserModel.unauthenticated() {
    return const AuthUserModel(
      user: User(
        id: '-99',
        appMetadata: {},
        userMetadata: {},
        createdAt: '',
        aud: '',
      ),
    );
  }

  /// The user associated with the authentication process.
  final User user;

  /// The session associated with the authenticated user.
  ///
  /// This can be `null` if there is no active session for the user.
  final Session? userSession;

  /// The current authentication status of the user.
  final AuthStatus authStatus;

  /// Returns a [bool] based on the user authentication status
  bool get isAuthenticated {
    return switch (authStatus) {
      AuthStatus.authenticated => true,
      AuthStatus.unauthenticated => false,
      AuthStatus.hasVerificationPending => false,
    };
  }

  @override
  List<Object?> get props => [user, userSession];
}
