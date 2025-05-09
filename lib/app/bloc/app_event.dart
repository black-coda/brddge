part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class AppLogoutRequested extends AppEvent {
  const AppLogoutRequested();
}

class AppOnboardingCompleted extends AppEvent {
  const AppOnboardingCompleted();
}

class AppOpened extends AppEvent {
  const AppOpened();
}

class AppAuthenticationChanged extends AppEvent {
  const AppAuthenticationChanged(this.user);

  final AuthUserModel user;

  @override
  List<Object> get props => [user];
}
