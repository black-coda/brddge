part of 'profile_bloc.dart';

enum ProfileUpdateStatus {
  initial,
  success,
  failure,
  loading,
}

class ProfileState extends Equatable {
  const ProfileState({
    required this.fullName,
    required this.occupation,
    required this.hobbies,
    required this.interests,
    required this.bio,
    required this.status,
  });

  factory ProfileState.initial() {
    return const ProfileState(
      fullName: '',
      occupation: '',
      hobbies: [],
      interests: [],
      bio: '',
      status: ProfileUpdateStatus.initial,
    );
  }

  final String fullName;
  final String occupation;
  final List<Hobby> hobbies;
  final List<Interest> interests;
  final String bio;
  final ProfileUpdateStatus status;

  ProfileState copyWith({
    String? fullName,
    String? occupation,
    List<Hobby>? hobbies,
    List<Interest>? interests,
    String? bio,
    ProfileUpdateStatus? status,
  }) {
    return ProfileState(
      fullName: fullName ?? this.fullName,
      occupation: occupation ?? this.occupation,
      hobbies: hobbies ?? this.hobbies,
      interests: interests ?? this.interests,
      bio: bio ?? this.bio,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        fullName,
        occupation,
        hobbies,
        interests,
        bio,
        status,
      ];
}
