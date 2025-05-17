import 'package:flutter/material.dart';
import 'package:get/utils.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    /// --AppBar
    appBar: TAppBar(
      title: Text(
        'My Orders',
        style: Theme.of(context).textTheme.headlineSmall),
        showBackArrow: true),
    body: const Padding(
      padding: EdgeInsets.all(TSize.defaultSpace),

      /// --Orders
      child: TOrderListItems(),
    ),
  );
}
