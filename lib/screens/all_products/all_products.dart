import 'package:flutter/material.dart';
import '../../common/widgets/products/sortable/sortable_products.dart';
import '../../common/widgets/appbar/appbar.dart';
import '../../common/widgets/layouts/grid_layout.dart';
import '../../common/widgets/products/product_cards/product_card_vertical.dart';
import '../../utils/constants/sizes.dart';
import '../../screens/sub_category/sub_categories.dart';

class AllProducts extends StatelessWidget {
  const AllProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: TAppBar(
        title: Text('All Products'),
        showBackArrow: true),
        body: SingleChildScrollView(
          child: Padding(padding: EdgeInsets.all(TSizes.defaultSpace),
            child: TSortableProduct(),
            ),
        ),
    );
  }
}
