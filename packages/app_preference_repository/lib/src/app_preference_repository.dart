import 'dart:developer';

import 'package:app_preferences_interface/app_preferences_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// {@template app_preference_repository}
/// Implements the app preference interface
/// {@endtemplate}
class AppPreferenceRepository implements AppPreferencesInterface {
  /// {@macro app_preference_repository}
  const AppPreferenceRepository({
    required SharedPreferences preferences,
    required SupabaseClient supabaseClient,
  })  : _preferences = preferences,
        _supabaseClient = supabaseClient;

  static const String _onboardingKey = 'has_completed_onboarding';

  final SharedPreferences _preferences;
  final SupabaseClient _supabaseClient;

  @override
  Future<void> markOnboardingAsComplete() async {
    await _preferences.setBool(_onboardingKey, true);
  }

  @override
  Future<bool> isOnboardingRequired() async {
    final onboardingStatus = _preferences.getBool(_onboardingKey);
    return onboardingStatus == null || !onboardingStatus;
  }

  @override
  Future<void> updateUserProfile(Map<String, dynamic> userProfileData) async {
    try {
      final currentUser = _supabaseClient.auth.currentUser;
      if (currentUser == null) {
        throw Exception('User not authenticated');
      }
      final userId = currentUser.id;
      await _supabaseClient
          .from(_profilesKey)
          .update(userProfileData)
          .eq('user_id', userId);
    } on Exception catch (e, st) {
      log('Error Updating Profile: $e');
      Error.throwWithStackTrace(ProfileUpdateException(e.toString()), st);
    }
  }

  static const String _interestKey = 'user_interests';
  static const String _hobbyKey = 'user_hubbies';
  static const String _profilesKey = 'profiles';

  @override
  Future<void> updateUserHobbies(List<Hobby> hobbies) async {
    final currentUser = _supabaseClient.auth.currentUser;
    if (currentUser == null) {
      throw Exception('User not authenticated');
    }
    // Convert to raw enum strings (e.g., ['Cooking', 'Hiking'])
    final hobbyStrings = hobbies.map((h) => h.name).toList();
    log(hobbyStrings.toString(), name: 'Hobbies as String');

    try {
      // Clear existing hobbies
      await _supabaseClient
          .from('user_hobbies')
          .delete()
          .eq('user_id', currentUser.id);
      // Insert new hobbies
      if (hobbyStrings.isNotEmpty) {
        final newHobbies = hobbyStrings
            .map(
              (hobby) => {
                'user_id': currentUser.id,
                'hobby': hobby,
              },
            )
            .toList();
        await _supabaseClient.from(_hobbyKey).upsert(newHobbies);
      }
    } on Exception catch (e, st) {
      Error.throwWithStackTrace(ProfileUpdateException(e.toString()), st);
    }
  }

  @override
  Future<void> updateUserInterests(List<Interest> interests) async {
    final currentUser = _supabaseClient.auth.currentUser;
    if (currentUser == null) {
      throw Exception('User not authenticated');
    }
    // Convert to raw enum strings (e.g., ['Cooking', 'Hiking'])
    final interestStrings = interests.map((h) => h.name).toList();
    log(interestStrings.toString(), name: 'Hobbies as String');

    try {
      // Clear existing hobbies
      await _supabaseClient
          .from('user_hobbies')
          .delete()
          .eq('user_id', currentUser.id);
      // Insert new hobbies
      if (interestStrings.isNotEmpty) {
        final newInterest = interestStrings
            .map(
              (hobby) => {
                'user_id': currentUser.id,
                'hobby': hobby,
              },
            )
            .toList();
        await _supabaseClient.from(_interestKey).upsert(newInterest);
      }
    } on Exception catch (e, st) {
      Error.throwWithStackTrace(ProfileUpdateException(e.toString()), st);
    }
  }
}
