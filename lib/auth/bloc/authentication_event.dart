part of 'authentication_bloc.dart';

sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class LoginWithEmailRequested extends AuthenticationEvent {
  const LoginWithEmailRequested({
    required this.credential,
  });

  final EmailAndPasswordCredential credential;

  @override
  List<Object> get props => [credential];
}

class LoginWithGoogleRequested extends AuthenticationEvent {
  const LoginWithGoogleRequested();
}

class RegisterWithEmailRequested extends AuthenticationEvent {
  const RegisterWithEmailRequested({
    required this.credential,
  });

  final EmailAndPasswordCredential credential;

  @override
  List<Object> get props => [credential];
}

class OTPAfterRegistrationRequested extends AuthenticationEvent {
  const OTPAfterRegistrationRequested({
    required this.credential,
  });

  final OTPVerificationCredential credential;

  @override
  List<Object> get props => [credential];
}
