import 'models/models.dart';

/// {@template app_preferences_interface}
/// Manages user preferences for the app.
/// {@endtemplate}
abstract class AppPreferencesInterface {
  /// {@macro app_preferences_interface}
  const AppPreferencesInterface();

  /// Returns [bool] (true) if the user has completed onboarding.
  ///
  /// Returns [bool] (false) if the user has not completed onboarding.
  Future<bool> isOnboardingRequired();

  /// Sets the user's onboarding status to [bool] => true.
  ///
  /// Returns [void].
  Future<void> markOnboardingAsComplete();

  /// Updates the user's profile with the provided [UserProfileData].
  ///
  /// This method takes a [UserProfileData] object containing the user's
  /// updated profile information and applies the changes.
  ///
  /// Returns [Future<void>] when the update is complete
  Future<void> updateUserProfile(Map<String, dynamic> userProfileData);

  /// Updates the user's hobbies with the provided [List<Hobby>].
  ///
  /// This method takes a [List<Hobbies>] object containing the user's
  ///
  /// updated hobbies and applies the changes.
  Future<void> updateUserHobbies(List<Hobby> hobbies);

  /// Updates the user's interests with the provided [List<Interest>].
  ///
  /// This method takes a [List<Interest>] object containing the user's
  /// updated interests and applies the changes.
  Future<void> updateUserInterests(List<Interest> interests);
}

/// {@template app_preferences_interface_exception}
/// Exception thrown when there is an error in the app preferences interface.
///
/// {@endtemplate}
class AppPreferencesInterfaceException implements Exception {
  /// {@macro app_preferences_interface_exception}
  const AppPreferencesInterfaceException(this.message);

  /// The error message.
  final String message;

  @override
  String toString() => 'AppPreferencesInterfaceException: $message';
}

/// {@template profile_update_exception}
/// Exception thrown when there is an error updating the user's profile.
///
/// This exception is used to indicate that an error occurred while attempting
/// to update the user's profile information in the app preferences interface.
///
/// {@endtemplate}
class ProfileUpdateException implements AppPreferencesInterfaceException {
  /// {@macro profile_update_exception}
  const ProfileUpdateException(this.message);

  /// The error message describing the profile update failure.
  @override
  final String message;

  @override
  String toString() => 'ProfileUpdateException: $message';
}
