import 'package:flutter/material.dart';
import '../../common/widgets/brands/brand_card.dart';
import '../../common/widgets/products/sortable/sortable_products.dart';
import '../../utils/constants/sizes.dart';
import '../../common/widgets/appbar/appbar.dart';

class BrandProducts extends StatelessWidget {
  const BrandProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(title: Text('Nike')),
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
              children: [
                /// Brand Detail
                TBrandCard(showBorder: true),
                SizedBox(height: TSizes.spaceBtwSections),

                TSortableProduct(),

          ],
        )),
      ),
    );
  }
}