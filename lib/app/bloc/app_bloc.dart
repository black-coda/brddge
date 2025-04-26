import 'dart:async' show FutureOr, StreamSubscription;
import 'dart:convert';
import 'dart:developer' show log;

import 'package:app_preference_repository/app_preference_repository.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc(this._authenticationRepository, this._appPreferenceRepository)
      : super(AppState.initial()) {
    on<AppOpened>(_onAppOpened);
    on<AppLogoutRequested>(_onAppLogoutRequested);
    on<AppOnboardingCompleted>(_onAppOnboardingCompleted);
    on<AppAuthenticationChanged>(_onAppAuthenticationChanged);
    _authenticationRepository.currentUserStream.listen((user) {
      log('Auth Stream Change Detected in AppBloc: $user');
      add(AppAuthenticationChanged(user));
    });
  }

  final AuthenticationRepository _authenticationRepository;
  final AppPreferenceRepository _appPreferenceRepository;
  late final StreamSubscription<AuthUserModel> _authSubscription;

  Future<void> _onAppOpened(AppOpened event, Emitter<AppState> emit) async {
    emit(state.copyWith(isLoading: true));

    // check if the user has completed onboarding
    final onboardingCompleted =
        await _appPreferenceRepository.isOnboardingRequired();
    if (onboardingCompleted) {
      emit(
        state.copyWith(
          isLoading: false,
          status: AppStatus.onBoardingRequired,
        ),
      );
      return;
    }

    log('Listening to authentication stream...');
    await emit.forEach(
      _authenticationRepository.currentUserStream,
      onData: (user) {
        log('new Event: $user');
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
      await _authenticationRepository.logOut().then(
        (_) {
          emit(
            state.copyWith(
              isLoading: false,
              status: AppStatus.unauthenticated,
            ),
          );
        },
      );
    } on Exception catch (error) {
      log(
        'Error fetching authentication(onAppLogout) state: $error',
        name: 'AppBloc',
      );
      emit(
        state.copyWith(
          isLoading: false,
          status: AppStatus.unauthenticated,
        ),
      );
    }
  }

  Future<void> _onAppOnboardingCompleted(
    AppOnboardingCompleted event,
    Emitter<AppState> emit,
  ) async {
    await _appPreferenceRepository.markOnboardingAsComplete();
    emit(state.copyWith(status: AppStatus.unauthenticated));
  }

  @override
  Future<void> close() {
    _authSubscription.cancel();
    _authenticationRepository.close();
    return super.close();
  }

  FutureOr<void> _onAppAuthenticationChanged(
    AppAuthenticationChanged event,
    Emitter<AppState> emit,
  ) {
    final user = event.user;
    emit(
      state.copyWith(
        user: user,
        isLoading: false,
        status: user.isAuthenticated
            ? AppStatus.authenticated
            : AppStatus.unauthenticated,
      ),
    );
  }
}
