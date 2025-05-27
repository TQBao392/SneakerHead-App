import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../screens/brand/brand_products.dart';
import '../../common/widgets/brands/brand_card.dart';
import '../../common/widgets/products/sortable/sortable_products.dart';
import '../../common/widgets/appbar/appbar.dart';
import '../../common/widgets/layouts/grid_layout.dart';
import '../../common/widgets/texts/section_heading.dart';
import '../../utils/constants/sizes.dart';

class AllBrands extends StatelessWidget {
  const AllBrands({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: Text('All Brands'),
      ),
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Heading
              const TSectionHeading(title: 'Brands'),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// Brands
              TGridLayout(itemCount: 10, mainAxisExtent: 80, itemBuilder: (context, index) => TBrandCard(
                  showBorder: true,
                  onTap: () => Get.to(() => const BrandProducts()),
              ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}