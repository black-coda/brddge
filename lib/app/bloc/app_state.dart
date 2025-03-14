part of 'app_bloc.dart';

enum AppStatus {
  authenticated(),
  unauthenticated(),
  onBoardingRequired(),
  initial()
}

@immutable
final class AppState extends Equatable {
  const AppState({
    required this.user,
    required this.status,
    this.isLoading = false,
  });

  AppState.initial()
      : this(
          user: AuthUserModel.unauthenticated(),
          status: AppStatus.initial,
        );

  final AuthUserModel user;
  final AppStatus status;
  final bool isLoading;

  @override
  List<Object?> get props => [user, status];

  AppState copyWith({
    AuthUserModel? user,
    AppStatus? status,
    bool? isLoading,
  }) {
    return AppState(
      user: user ?? this.user,
      status: status ?? this.status,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
