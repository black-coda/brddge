import 'dart:async';
import 'dart:developer' show log;

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(AuthenticationInitial()) {
    on<LoginWithEmailRequested>(_onLoginWithEmailRequested);
    on<LoginWithGoogleRequested>(_onLoginWithGoogleRequested);
    on<RegisterWithEmailRequested>(_onRegisterWithEmailRequested);
    on<OTPAfterRegistrationRequested>(_onOTPAfterRegistrationRequested);
  }

  final AuthenticationRepository _authenticationRepository;

  FutureOr<void> _onLoginWithEmailRequested(
    LoginWithEmailRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(const AuthenticationLoading());
    try {
      await _authenticationRepository.logInWithEmail(
        event.credential,
      );
      emit(const AuthenticationSuccess());
    } on AuthenticationException catch (e) {
      emit(AuthenticationFailed(error: e.errorMsg));
    } catch (e, stackTrace) {
      log('Unexpected error: $e', stackTrace: stackTrace);
      emit(const AuthenticationFailed(error: 'An unexpected error occurred'));
    }
  }

  FutureOr<void> _onLoginWithGoogleRequested(
    LoginWithGoogleRequested event,
    Emitter<AuthenticationState> emit,
  ) {}

  FutureOr<void> _onRegisterWithEmailRequested(
    RegisterWithEmailRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(const AuthenticationLoading());
    try {
      await _authenticationRepository.signUpWithEmail(event.credential).then(
        (value) {
          emit(const AuthenticationSuccess());
        },
      );
    } on AuthenticationException catch (e) {
      emit(AuthenticationFailed(error: e.errorMsg));
    } catch (e, stackTrace) {
      log('Unexpected error: $e', stackTrace: stackTrace);
      emit(const AuthenticationFailed(error: 'An unexpected error occurred'));
    }
  }

  FutureOr<void> _onOTPAfterRegistrationRequested(
    OTPAfterRegistrationRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(const AuthenticationLoading());
    try {
      await _authenticationRepository.verifyOTP(event.credential);
      emit(const AuthenticationOPTSuccess());
    } on AuthenticationException catch (e) {
      emit(
        AuthenticationFailed(error: e.errorMsg),
      );
    } catch (e, stackTrace) {
      log('Unexpected error: $e', stackTrace: stackTrace);
      emit(const AuthenticationFailed(error: 'An unexpected error occurred'));
    }
  }
}
