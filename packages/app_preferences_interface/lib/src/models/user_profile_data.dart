import 'package:app_preferences_interface/src/models/models.dart';

/// Represents the user profile data.
///
/// This class is immutable and contains all the necessary fields
/// to represent a user's profile information.
class UserProfileData {
  /// Creates a new instance of [UserProfileData].
  ///
  /// All fields are required except for [avatarUrl], which is optional.
  const UserProfileData({
    required this.email,
    required this.fullName,
    required this.hobbies,
    required this.interests,
    required this.occupation,
    required this.bio,
    this.avatarUrl,
  });

  /// The email address of the user.
  final String email;

  /// The full name of the user.
  final String fullName;

  /// A list of the user's hobbies.
  final List<Hobby> hobbies;

  /// A list of the user's interests.
  final List<Interest> interests;

  /// The user's occupation.
  final String occupation;

  /// A short biography of the user.
  final String bio;

  /// The URL of the user's avatar image.
  final String? avatarUrl;

  /// Creates a copy of this [UserProfileData] with updated fields.
  ///
  /// If a field is not provided, the current value is retained.
  UserProfileData copyWith({
    String? email,
    String? fullName,
    List<Hobby>? hobbies,
    List<Interest>? interests,
    String? occupation,
    String? bio,
    String? avatarUrl,
  }) {
    return UserProfileData(
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      hobbies: hobbies ?? this.hobbies,
      interests: interests ?? this.interests,
      occupation: occupation ?? this.occupation,
      bio: bio ?? this.bio,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }
}
