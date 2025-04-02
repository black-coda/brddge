part of 'app_bloc.dart';

enum AppStatus {
  authenticated(),
  unauthenticated(),
  onBoardingRequired(),
  initial();

  static AppStatus fromString(String authStatus) {
    return switch (authStatus) {
      'authenticated' => AppStatus.authenticated,
      'unauthenticated' => AppStatus.unauthenticated,
      'onBoardingRequired' => AppStatus.onBoardingRequired,
      _ => AppStatus.initial,
    };
  }
}

@immutable
class AppState extends Equatable {
  const AppState({
    required this.user,
    required this.status,
    this.isLoading = false,
  });

  factory AppState.fromMap(Map<String, dynamic> map) {
    return AppState(
      user: AuthUserModel.fromMap(map['user'] as Map<String, dynamic>),
      status: AppStatus.fromString(map['status'] as String),
      isLoading: map['isLoading'] as bool,
    );
  }

  factory AppState.fromJson(String source) =>
      AppState.fromMap(json.decode(source) as Map<String, dynamic>);

  AppState.initial()
      : this(
          user: AuthUserModel.unauthenticated(),
          status: AppStatus.initial,
        );

  final AuthUserModel user;
  final AppStatus status;
  final bool isLoading;

  @override
  List<Object?> get props => [user, status, isLoading];

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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user': user.toMap(),
      'status': status.toString(),
      'isLoading': isLoading,
    };
  }

  String toJson() => json.encode(toMap());
}
