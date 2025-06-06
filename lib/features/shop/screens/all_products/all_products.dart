import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sneakerhead/common/widgets/appbar/appbar.dart';
import 'package:sneakerhead/common/widgets/products/sortable/sortable_products.dart';
import 'package:sneakerhead/common/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:sneakerhead/features/shop/controllers/all_products_controller.dart';
import 'package:sneakerhead/features/shop/models/product_model.dart';
import 'package:sneakerhead/utils/constants/sizes.dart';
import 'package:sneakerhead/utils/helpers/cloud_helper_functions.dart';

class AllProducts extends StatelessWidget {
  const AllProducts({
    super.key,
    required this.title,
    this.query,
    this.futureMethod,
  });

  final String title;
  final Query? query;
  final Future<List<ProductModel>>? futureMethod;

  @override
  Widget build(BuildContext context) {
    // Initialize controller for managing product fetching
    final controller = Get.put(AllProductsController());

    return Scaffold(
      /// AppBar
      appBar: TAppBar(title: Text(title), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: FutureBuilder(
            future: futureMethod ?? controller.fetchProductsByQuery(query),
            builder: (context, snapshot) {
              // Check the state of the FutureBuilder snapshot
              const loader = TVerticalProductShimmer();
              final widget = TCloudHelperFunctions.checkMultiRecordState(
                snapshot: snapshot,
                loader: loader,
              );

              // Return approriate widget based on snapshot state
              if (widget != null) return widget;

              // Products found!
              final products = snapshot.data!;
              return TSortableProduct(products: products);
            },
          ),
        ),
      ),
    );
  }
}
