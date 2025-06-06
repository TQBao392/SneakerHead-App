import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sneakerhead/common/widgets/appbar/appbar.dart';
import 'package:sneakerhead/common/widgets/brands/brand_card.dart';
import 'package:sneakerhead/common/widgets/layouts/grid_layout.dart';
import 'package:sneakerhead/common/widgets/shimmers/brands_shimmer.dart';
import 'package:sneakerhead/common/widgets/texts/section_heading.dart';
import 'package:sneakerhead/features/shop/controllers/brand_controller.dart';
import 'package:sneakerhead/features/shop/screens/brand/brand_products.dart';
import 'package:sneakerhead/utils/constants/sizes.dart';

class AllBrands extends StatelessWidget {
  const AllBrands({super.key});

  @override
  Widget build(BuildContext context) {
    final brandController = BrandController.instance;
    return Scaffold(
      appBar: TAppBar(title: Text('All Brands')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Heading
              const TSectionHeading(title: 'Brands', showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// Brands
              Obx(() {
                if (brandController.isLoading.value) {
                  return const TBrandsShimmer();
                }

                if (brandController.allBrands.isEmpty) {
                  return Center(
                    child: Text(
                      'No Data Found!',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium!.apply(color: Colors.white),
                    ),
                  );
                }
                return TGridLayout(
                  itemCount: brandController.allBrands.length,
                  mainAxisExtent: 80,
                  itemBuilder: (_, index) {
                    final brand = brandController.allBrands[index];
                    return TBrandCard(
                      showBorder: true,
                      brand: brand,
                      onTap: () => Get.to(() => BrandProducts(brand: brand)),
                    );
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
