import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sneakerhead/common/widgets/appbar/tabbar.dart';
import 'package:sneakerhead/common/widgets/brands/brand_card.dart';

import 'package:sneakerhead/common/widgets/custom_shapes/containers/search_container.dart';

import 'package:sneakerhead/common/widgets/layouts/grid_layout.dart';
import 'package:sneakerhead/common/widgets/appbar/appbar.dart';
import 'package:sneakerhead/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:sneakerhead/common/widgets/shimmers/brands_shimmer.dart';
import 'package:sneakerhead/common/widgets/texts/section_heading.dart';

import 'package:sneakerhead/features/shop/controllers/brand_controller.dart';
import 'package:sneakerhead/features/shop/controllers/category_controller.dart';
import 'package:sneakerhead/features/shop/screens/brand/all_brands.dart';
import 'package:sneakerhead/features/shop/screens/brand/brand_products.dart';
import 'package:sneakerhead/features/shop/screens/store/widgets/category_tab.dart';
import 'package:sneakerhead/utils/constants/colors.dart';

import 'package:sneakerhead/utils/constants/sizes.dart';
import 'package:sneakerhead/utils/helpers/helper_functions.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brandController = Get.put(BrandController());
    final categories = CategoryController.instance.featuredCategories;
    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        appBar: TAppBar(
          title: Text(
            'Store',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          actions: [
            TCartCounterIcon(
              iconColor: TColors.white,
              counterBgColor: TColors.black,
              counterTextColor: TColors.white,
            ),
          ],
        ),
        body: NestedScrollView(
          headerSliverBuilder: (_, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                floating: true,
                backgroundColor:
                    THelperFunctions.isDarkMode(context)
                        ? TColors.black
                        : TColors.white,
                expandedHeight: 440,

                flexibleSpace: Padding(
                  padding: EdgeInsets.all(TSizes.defaultSpace),
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      /// -- Search bar
                      const SizedBox(height: TSizes.spaceBtwItems),
                      const TSearchContainer(
                        text: 'Search Product',
                        showBorder: true,
                        showBackground: false,
                        padding: EdgeInsets.zero,
                      ),
                      const SizedBox(height: TSizes.spaceBtwSections),

                      /// -- Featured Brands
                      TSectionHeading(
                        title: ' Featured Brands',
                        onPressed: () => Get.to(() => const AllBrands()),
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems / 1.5),

                      /// -- Brands GRID
                      Obx(() {
                        if (brandController.isLoading.value) {
                          return const TBrandsShimmer();
                        }

                        if (brandController.featuredBrands.isEmpty) {
                          return Center(
                            child: Text(
                              'No Data Found!',
                              style: Theme.of(context).textTheme.bodyMedium!
                                  .apply(color: Colors.white),
                            ),
                          );
                        }
                        return TGridLayout(
                          itemCount: brandController.featuredBrands.length,
                          mainAxisExtent: 80,
                          itemBuilder: (_, index) {
                            final brand = brandController.featuredBrands[index];
                            return TBrandCard(
                              showBorder: true,
                              brand: brand,
                              onTap:
                                  () =>
                                      Get.to(() => BrandProducts(brand: brand)),
                            );
                          },
                        );
                      }),
                    ],
                  ),
                ),

                /// Tabs -- Tutorial (Section #3, Video #8)
                bottom: TTabBar(
                  tabs:
                      categories
                          .map((category) => Tab(child: Text(category.name)))
                          .toList(),
                ),
              ),
            ];
          },
          body: TabBarView(
            children:
                categories
                    .map((category) => TCategoryTab(category: category))
                    .toList(),
          ),
        ),
      ),
    );
  }
}
