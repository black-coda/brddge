import 'package:app_preference_repository/app_preference_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(AppPreferenceRepository appPref)
      : _appPreferenceRepository = appPref,
        super(ProfileState.initial()) {
    onProfileFullNameChanged();
  }

  final AppPreferenceRepository _appPreferenceRepository;

  void onProfileFullNameChanged() {
    on<ProfileFullNameChanged>((event, emit) {
      emit(state.copyWith(fullName: event.fullName));
    });
  }

  void onProfileOccupationChanged() {
    on<ProfileOccupationChanged>((event, emit) {
      emit(state.copyWith(occupation: event.occupation));
    });
  }

  void onProfileHobbiesChanged() {
    on<ProfileHobbiesChanged>((event, emit) {
      emit(state.copyWith(hobbies: event.hobbies));
    });
  }

  void onProfileInterestsChanged() {
    on<ProfileInterestsChanged>((event, emit) {
      emit(state.copyWith(interests: event.interests));
    });
  }

  void onProfileBioChanged() {
    on<ProfileBioChanged>((event, emit) {
      emit(state.copyWith(bio: event.bio));
    });
  }

  void onProfileUpdateRequested() {
    // TODO: Implement the logic to know which fields have changed
    on<ProfileUpdateSubmitted>((event, emit) async {
      emit(state.copyWith(status: ProfileUpdateStatus.loading));
      final userProfileData = {
        'full_name': state.fullName,
        'occupation': state.occupation,
        'hobbies': state.hobbies,
        'interests': state.interests,
        'bio': state.bio,
      };
      try {
        await _appPreferenceRepository.updateUserProfile(
          userProfileData,
        );
        emit(state.copyWith(status: ProfileUpdateStatus.success));
      } catch (e) {
        emit(state.copyWith(status: ProfileUpdateStatus.failure));
      }
    });
  }
}
