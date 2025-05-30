import 'package:flutter/material.dart';
import 'package:t_store/features/authentication/screens/cart/checkout_screen.dart' as co;
import 'package:t_store/features/authentication/screens/cart/cart_screen.dart';
import 'features/authentication/screens/profile/profile_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  co.CheckoutScreen(),
    );
  }
}
