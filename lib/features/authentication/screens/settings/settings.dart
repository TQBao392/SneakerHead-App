import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  SettingsScreenState createState() => SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen> {
  bool receivePromotions = true;
  bool darkMode = false;
  bool useHighResImages = true;

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
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Shop'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: 'Wishlist'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
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
                        'John Sneakerhead',
                        style: TextStyle(
                            color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'john.sneaker@example.com',
                        style: TextStyle(color: Colors.white70, fontSize: 14),
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
                    'Shopping Preferences',
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  _buildTile(
                    icon: Icons.shopping_bag,
                    title: 'My Orders',
                    subtitle: 'Track past and current orders',
                  ),
                  _buildTile(
                    icon: Icons.credit_card,
                    title: 'Payment Methods',
                    subtitle: 'Manage credit cards and other payment options',
                  ),
                  _buildTile(
                    icon: Icons.local_shipping,
                    title: 'Delivery Settings',
                    subtitle: 'Preferred delivery times and locations',
                  ),
                  _buildTile(
                    icon: Icons.location_on,
                    title: 'Saved Addresses',
                    subtitle: 'Manage shipping addresses',
                  ),
                  _buildTile(
                    icon: Icons.discount,
                    title: 'My Coupons',
                    subtitle: 'Available promo codes and offers',
                  ),
                  _buildTile(
                    icon: Icons.favorite,
                    title: 'Wishlist',
                    subtitle: 'Shoes you’ve liked',
                  ),

                  const SizedBox(height: 24),
                  const Text(
                    'App Settings',
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    activeColor: Colors.purpleAccent,
                    title: const Text('Receive Promotions', style: TextStyle(color: Colors.white)),
                    subtitle: const Text('Get updates on new releases and sales',
                        style: TextStyle(color: Colors.white60)),
                    value: receivePromotions,
                    onChanged: (val) => setState(() => receivePromotions = val),
                    secondary: const Icon(Icons.notifications_active, color: Colors.purpleAccent),
                  ),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    activeColor: Colors.purpleAccent,
                    title: const Text('Dark Mode', style: TextStyle(color: Colors.white)),
                    subtitle: const Text('Switch app theme', style: TextStyle(color: Colors.white60)),
                    value: darkMode,
                    onChanged: (val) => setState(() => darkMode = val),
                    secondary: const Icon(Icons.dark_mode, color: Colors.purpleAccent),
                  ),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    activeColor: Colors.purpleAccent,
                    title: const Text('HD Images', style: TextStyle(color: Colors.white)),
                    subtitle:
                    const Text('Show product images in high quality', style: TextStyle(color: Colors.white60)),
                    value: useHighResImages,
                    onChanged: (val) => setState(() => useHighResImages = val),
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
                      onPressed: () {
                        // TODO: Add logout logic
                      },
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
