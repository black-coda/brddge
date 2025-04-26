part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class ProfileFullNameChanged extends ProfileEvent {
  const ProfileFullNameChanged(this.fullName);

  final String fullName;

  @override
  List<Object?> get props => [fullName];
}

class ProfileOccupationChanged extends ProfileEvent {
  const ProfileOccupationChanged(this.occupation);

  final String occupation;

  @override
  List<Object?> get props => [occupation];
}

class ProfileHobbiesChanged extends ProfileEvent {
  const ProfileHobbiesChanged(this.hobbies);

  final List<Hobby> hobbies;

  @override
  List<Object?> get props => [hobbies];
}

class ProfileInterestsChanged extends ProfileEvent {
  const ProfileInterestsChanged(this.interests);

  final List<Interest> interests;

  @override
  List<Object?> get props => [interests];
}

class ProfileBioChanged extends ProfileEvent {
  const ProfileBioChanged(this.bio);

  final String bio;

  @override
  List<Object?> get props => [bio];
}

class ProfileUpdateSubmitted extends ProfileEvent {
  const ProfileUpdateSubmitted();
}
