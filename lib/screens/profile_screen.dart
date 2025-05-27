import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Widget _buildRow({
    required String title,
    required String value,
    VoidCallback? onTap,
    bool showCopyIcon = false,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: TextStyle(fontSize: 16)),
            Row(
              children: [
                Text(value, style: TextStyle(fontSize: 16, color: Colors.grey[700])),
                if (showCopyIcon) ...[
                  SizedBox(width: 8),
                  Icon(Icons.copy_outlined, size: 20, color: Colors.grey),
                ] else if (onTap != null) ...[
                  SizedBox(width: 8),
                  Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                ]
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text('Profile', style: TextStyle(color: Colors.black)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 16),
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/avatar.png'),
              ),
              SizedBox(height: 8),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Change Profile Picture',
                  style: TextStyle(color: Colors.blue, fontSize: 14),
                ),
              ),
              SizedBox(height: 16),
              Divider(thickness: 1),

              // Profile Information Section
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Profile Information',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              SizedBox(height: 8),
              _buildRow(title: 'Name', value: 'Coding with T', onTap: () {}),
              Divider(height: 0),
              _buildRow(title: 'Username', value: 'coding_with_t', onTap: () {}),
              Divider(thickness: 1),

              SizedBox(height: 16),

              // Personal Information Section
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Personal Information',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              SizedBox(height: 8),
              _buildRow(title: 'User ID', value: '45689', showCopyIcon: true),
              Divider(height: 0),
              _buildRow(title: 'E-mail', value: 'coding_with_t', onTap: () {}),
              Divider(height: 0),
              _buildRow(title: 'Phone Number', value: '+92-317-8059528', onTap: () {}),
              Divider(height: 0),
              _buildRow(title: 'Gender', value: 'Male', onTap: () {}),
              Divider(height: 0),
              _buildRow(title: 'Date of Birth', value: '10 Oct, 1994', onTap: () {}),
              Divider(thickness: 1),
            ],
          ),
        ),
      ),
    );
  }
}
