import 'package:flutter/material.dart';
import 'package:t_store/data/models/profile_model.dart';
import 'package:t_store/features/profile/services/profile_service.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final ProfileService _profileService = ProfileService();

  Widget _buildRow({required String title, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: 16)),
          Text(value, style: TextStyle(fontSize: 16, color: Colors.grey[700])),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Profile>(
      future: _profileService.getUserProfile(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return const Scaffold(
            body: Center(child: Text('Error loading profile')),
          );
        }

        final profile = snapshot.data!;

        return Scaffold(
          appBar: AppBar(title: const Text('Profile')),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(profile.avatarUrl),
                ),
                const SizedBox(height: 8),
                Text(profile.name, style: const TextStyle(fontSize: 20)),
                const SizedBox(height: 24),
                _buildRow(title: 'Username', value: profile.username),
                _buildRow(title: 'Email', value: profile.email),
                _buildRow(title: 'Phone', value: profile.phoneNumber),
                _buildRow(title: 'Gender', value: profile.gender),
                _buildRow(title: 'DOB', value: profile.dob),
                _buildRow(title: 'User ID', value: profile.userId),
              ],
            ),
          ),
        );
      },
    );
  }
}
