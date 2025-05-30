import 'package:t_store/data/models/profile_model.dart';

class ProfileService {
  static Profile? _currentProfile;

  Future<Profile> getUserProfile() async {
    await Future.delayed(const Duration(seconds: 2));

    _currentProfile ??= Profile(
      name: 'Alex Johnson',
      username: 'alex_sneakerhead',
      userId: 'U1023',
      email: 'alex.johnson@example.com',
      phoneNumber: '+1-555-0123',
      gender: 'Male',
      dob: '1992-07-15',
      avatarUrl: 'assets/images/avatar.png',
    );

    print('Fetched profile: $_currentProfile');
    return _currentProfile!;
  }

  Future<void> updateUserProfile(Profile updatedProfile) async {
    await Future.delayed(const Duration(seconds: 1));

    // Relaxed validation to align with EditProfileScreen
    if (updatedProfile.userId != _currentProfile?.userId) {
      throw Exception('User ID cannot be changed');
    }
    if (updatedProfile.username != _currentProfile?.username) {
      throw Exception('Username cannot be changed');
    }

    print('Updating profile: $updatedProfile');
    _currentProfile = updatedProfile;
  }
}