import '../../../data/models/profile_model.dart';

class ProfileService {
  Future<Profile> getUserProfile() async {
    await Future.delayed(Duration(seconds: 2));

    return Profile(
      name: 'Alex Johnson',
      username: 'alex_sneakerhead',
      userId: 'U1023',
      email: 'alex.johnson@example.com',
      phoneNumber: '+1-555-0123',
      gender: 'Male',
      dob: '1992-07-15',
      avatarUrl: 'assets/images/avatar.png',
    );
  }
}
