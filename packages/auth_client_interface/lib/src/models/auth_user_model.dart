// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart' show Session, User;

/// Represents the authentication status of a user.
enum AuthStatus {
  /// The user is authenticated.
  authenticated,

  /// The user is not authenticated.
  unauthenticated,

  /// The user is not verified.
  hasVerificationPending;

  static AuthStatus fromString(String authStatus) {
    return switch (authStatus) {
      'authenticated' => AuthStatus.authenticated,
      'unauthenticated' => AuthStatus.unauthenticated,
      'hasVerificationPending' => AuthStatus.hasVerificationPending,
      _ => AuthStatus.unauthenticated,
    };
  }
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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user': user.toJson(),
      'userSession': userSession?.toJson(),
      'authStatus': authStatus.toString(),
    };
  }

  factory AuthUserModel.fromMap(Map<String, dynamic> map) {
    return AuthUserModel(
      user: User.fromJson(map['user'] as Map<String, dynamic>)!,
      userSession: Session.fromJson(map['userSession'] as Map<String, dynamic>),
      authStatus: AuthStatus.fromString(map['authStatus'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthUserModel.fromJson(String source) =>
      AuthUserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
