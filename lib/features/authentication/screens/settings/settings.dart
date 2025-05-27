import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  SettingsScreenState createState() => SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen> {
  bool geolocation = true;
  bool safeMode = false;
  bool hdImageQuality = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        currentIndex: 3,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Store',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Wishlist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 160,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFF3A3D98),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 40,
                  left: 16,
                  child: CircleAvatar(
                    radius: 32,
                    backgroundImage: AssetImage('assets/images/avatar.png'),
                  ),
                ),
                Positioned(
                  top: 50,
                  left: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Coding with T',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'support@codingwithT.com',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 48,
                  right: 16,
                  child: IconButton(
                    icon: const Icon(Icons.edit, color: Colors.white),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  const Text(
                    'Account Settings',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildTile(
                    icon: Icons.location_on_outlined,
                    title: 'My Addresses',
                    subtitle: 'Set shopping delivery address',
                  ),
                  _buildTile(
                    icon: Icons.shopping_cart_outlined,
                    title: 'My Cart',
                    subtitle: 'Add, remove products and move to checkout',
                  ),
                  _buildTile(
                    icon: Icons.list_alt_outlined,
                    title: 'My Orders',
                    subtitle: 'In-progress and Completed Orders',
                  ),
                  _buildTile(
                    icon: Icons.account_balance_outlined,
                    title: 'Bank Account',
                    subtitle: 'Withdraw balance to registered bank account',
                  ),
                  _buildTile(
                    icon: Icons.card_giftcard,
                    title: 'My Coupons',
                    subtitle: 'List of all discounted coupons',
                  ),
                  _buildTile(
                    icon: Icons.notifications_outlined,
                    title: 'Notifications',
                    subtitle: 'Set any kind of notification message',
                  ),
                  _buildTile(
                    icon: Icons.lock_outline,
                    title: 'Account Privacy',
                    subtitle: 'Manage data usage and connected accounts',
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'App Settings',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildTile(
                    icon: Icons.cloud_upload_outlined,
                    title: 'Load Data',
                    subtitle: 'Upload Data to your Cloud Firebase',
                  ),
                  SwitchListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                    activeColor: Colors.purpleAccent,
                    title: const Text('Geolocation', style: TextStyle(color: Colors.white)),
                    subtitle: const Text('Set recommendation based on location', style: TextStyle(color: Colors.white60)),
                    value: geolocation,
                    onChanged: (val) => setState(() => geolocation = val),
                    secondary: const Icon(Icons.gps_fixed, color: Colors.purpleAccent),
                  ),
                  SwitchListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                    activeColor: Colors.purpleAccent,
                    title: const Text('Safe Mode', style: TextStyle(color: Colors.white)),
                    subtitle: const Text('Search result is safe for all ages', style: TextStyle(color: Colors.white60)),
                    value: safeMode,
                    onChanged: (val) => setState(() => safeMode = val),
                    secondary: const Icon(Icons.shield, color: Colors.purpleAccent),
                  ),
                  SwitchListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                    activeColor: Colors.purpleAccent,
                    title: const Text('HD Image Quality', style: TextStyle(color: Colors.white)),
                    subtitle: const Text('Set image quality to be seen', style: TextStyle(color: Colors.white60)),
                    value: hdImageQuality,
                    onChanged: (val) => setState(() => hdImageQuality = val),
                    secondary: const Icon(Icons.hd, color: Colors.purpleAccent),
                  ),
                  const SizedBox(height: 32),
                  Center(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.white60),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 12),
                      ),
                      onPressed: () {},
                      child: const Text('Logout', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTile({
    required IconData icon,
    required String title,
    required String subtitle,
    VoidCallback? onTap,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: Colors.purpleAccent),
      title: Text(title, style: const TextStyle(color: Colors.white, fontSize: 16)),
      subtitle: Text(subtitle, style: const TextStyle(color: Colors.white60)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white60),
      onTap: onTap ?? () {},
    );
  }
}
