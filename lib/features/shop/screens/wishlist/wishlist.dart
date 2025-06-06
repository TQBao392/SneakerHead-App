import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sneakerhead/common/widgets/appbar/appbar.dart';
import 'package:sneakerhead/common/widgets/icons/t_circular_icon.dart';
import 'package:sneakerhead/common/widgets/layouts/grid_layout.dart';
import 'package:sneakerhead/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:sneakerhead/common/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:sneakerhead/features/shop/controllers/product/favourites_controller.dart';
import 'package:sneakerhead/features/shop/screens/home/home.dart';
import 'package:sneakerhead/navigation_menu.dart';
import 'package:sneakerhead/utils/constants/image_strings.dart';
import 'package:sneakerhead/utils/constants/sizes.dart';
import 'package:sneakerhead/utils/helpers/cloud_helper_functions.dart';
import 'package:sneakerhead/utils/loaders/animation_loader.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = FavouritesController.instance;
    return Scaffold(
      appBar: TAppBar(
        title: Text(
          'Wishlist',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          TCircularIcon(
            icon: Iconsax.add,
            onPressed: () => Get.to(const HomeScreen()),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),

          /// Products Grid
          child: Obx(
            () => FutureBuilder(
              future: controller.favoriteProducts(),
              builder: (context, snapshot) {
                // Nothing Found Widget
                final emptyWidget = TAnimationLoaderWidget(
                  text: 'Whoops! Wishlist is Empty...',
                  animation: TImages.pencilAnimation,
                  showAction: true,
                  actionText: 'Let\'s add some',
                  onActionPressed: () => Get.off(() => const NavigationMenu()),
                );

                const loader = TVerticalProductShimmer(itemCount: 6);
                final widget = TCloudHelperFunctions.checkMultiRecordState(
                  snapshot: snapshot,
                  loader: loader,
                  nothingFound: emptyWidget,
                );
                if (widget != null) return widget;

                final products = snapshot.data!;
                return TGridLayout(
                  itemCount: products.length,
                  itemBuilder:
                      (_, index) =>
                          TProductCardVertical(product: products[index]),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
