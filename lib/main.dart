import 'package:flutter/material.dart';
import 'navigation/main_navigation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Nav App',
      theme: ThemeData.dark(),
      home: const MainNavigation(),
    );
  }
}
