import 'package:flutter/material.dart';
import 'package:sneaker_app/screens/cart_screen.dart';
import 'package:sneaker_app/screens/profile_screen.dart';
import 'package:sneaker_app/screens/setting_screen.dart';
import 'package:sneaker_app/widgets/bottom_nav.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    SettingsScreen(), // index 0
    ProfileScreen(),  // index 1
    CartPage(), //index 2
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
