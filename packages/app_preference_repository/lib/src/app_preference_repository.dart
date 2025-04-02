import 'package:app_preferences_interface/app_preferences_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// {@template app_preference_repository}
/// Implements the app preference interface
/// {@endtemplate}
class AppPreferenceRepository implements AppPreferencesInterface {
  /// {@macro app_preference_repository}
  const AppPreferenceRepository({
    required SharedPreferences preferences,
  }) : _preferences = preferences;

  static const String _onboardingKey = 'has_completed_onboarding';

  final SharedPreferences _preferences;

  @override
  Future<void> markOnboardingAsComplete() async {
    await _preferences.setBool(_onboardingKey, true);
  }

  @override
  Future<bool> isOnboardingRequired() async {
    final onboardingStatus = _preferences.getBool(_onboardingKey);
    return onboardingStatus == null || !onboardingStatus;
  }
}
