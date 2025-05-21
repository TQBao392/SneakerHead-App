import 'package:flutter/material.dart';
import 'package:sneakerhead/common/widgets/appbar/appbar.dart';

class AllProducts extends StatelessWidget {
  const AllProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(title: Text('Popular Products'), showBackArrow: true),
      );
      body: const Center(
        child: Text('All Products'),
      ),
    );
  }
}