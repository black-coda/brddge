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
}
