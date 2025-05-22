import 'package:flutter/material.dart';
import 'package:sneakerhead/screens/cart_screen.dart';
import 'package:sneakerhead/screens/profile_screen.dart';
import 'package:sneakerhead/screens/setting_screen.dart';
import 'package:sneakerhead/widgets/bottom_nav.dart';

import '../features/authentication/screens/settings/settings.dart';
import '../screens/cart_screen.dart';
import '../screens/profile_screen.dart';
import '../widgets/bottom_nav.dart';

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
    CartScreen(), //index 2
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
