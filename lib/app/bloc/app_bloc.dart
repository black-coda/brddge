import 'dart:developer' show log;

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc(this._authenticationRepository) : super(AppState.initial()) {
    on<AppOpened>(_onAppOpened);
    on<AppLogoutRequested>(_onAppLogoutRequested);
    on<AppOnboardingCompleted>(_onAppOnboardingCompleted);
  }

  final AuthenticationRepository _authenticationRepository;

  Future<void> _onAppOpened(AppOpened event, Emitter<AppState> emit) async {
    emit(state.copyWith(isLoading: true));
    await emit.forEach(
      _authenticationRepository.user(),
      onData: (user) {
        if (!user.isAuthenticated) {
          return state.copyWith(
            user: user,
            isLoading: false,
            status: AppStatus.unauthenticated,
          );
        } else {
          return state.copyWith(
            isLoading: false,
            user: user,
            status: AppStatus.authenticated,
          );
        }
      },
      onError: (error, stackTrace) {
        log(
          'Error fetching authentication(onAppOpened) state: $error',
          name: 'AppBloc',
        );
        return state.copyWith(
          isLoading: false,
          status: AppStatus.unauthenticated,
        );
      },
    );
  }

  Future<void> _onAppLogoutRequested(
    AppLogoutRequested event,
    Emitter<AppState> emit,
  ) async {
    try {
      await _authenticationRepository.logOut();
    } on Exception catch (error) {
      log(
        'Error fetching authentication(onAppLogout) state: $error',
        name: 'AppBloc',
      );
      state.copyWith(
        isLoading: false,
        status: AppStatus.unauthenticated,
      );
    }
  }

  Future<void> _onAppOnboardingCompleted(
    AppOnboardingCompleted event,
    Emitter<AppState> emit,
  ) async {
    // TODO: Implement onboarding completed
  }

  @override
  Future<void> close() {
    _authenticationRepository.close();
    return super.close();
  }
}
