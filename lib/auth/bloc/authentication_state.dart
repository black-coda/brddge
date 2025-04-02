part of 'authentication_bloc.dart';

sealed class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

final class AuthenticationInitial extends AuthenticationState {}

final class AuthenticationLoading extends AuthenticationState {
  const AuthenticationLoading();
}

final class AuthenticationSuccess extends AuthenticationState {
  const AuthenticationSuccess();
}

final class AuthenticationOPTSuccess extends AuthenticationState {
  const AuthenticationOPTSuccess();
}

final class AuthenticationFailed extends AuthenticationState {
  const AuthenticationFailed({
    required this.error,
  });

  final String error;

  @override
  List<Object> get props => [error];
}
