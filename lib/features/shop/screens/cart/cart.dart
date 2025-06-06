import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sneakerhead/common/widgets/appbar/appbar.dart';
import 'package:sneakerhead/common/widgets/loaders/animation_loader.dart';

import 'package:sneakerhead/features/shop/controllers/product/cart_controller.dart';
import 'package:sneakerhead/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:sneakerhead/features/shop/screens/checkout/checkout.dart';
import 'package:sneakerhead/navigation_menu.dart';

import 'package:sneakerhead/utils/constants/image_strings.dart';
import 'package:sneakerhead/utils/constants/sizes.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text('Cart', style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: Obx(() {
        /// Nothing Found Widget
        final emptyWidget = TAnimationLoaderWidget(
          text: 'Whoops! Cart is EMPTY',
          animation: TImages.carAnimation,
          showAction: true,
          actionText: 'Let\'s fill it',
          onActionPressed: () => Get.off(() => const NavigationMenu()),
        );

        if (controller.cartItems.isEmpty) {
          return emptyWidget;
        } else {
          return const SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(TSizes.defaultSpace),

              /// -- Items in cart
              child: TCartItems(),
            ),
          );
        }
      }),

      /// Checkout Button
      bottomNavigationBar:
          controller.cartItems.isEmpty
              ? const SizedBox()
              : Padding(
                padding: const EdgeInsets.all(TSizes.defaultSpace),
                child: ElevatedButton(
                  onPressed: () => Get.to(() => const CheckoutScreen()),
                  child: Obx(
                    () => Text('Checkout \$${controller.totalCartPrice.value}'),
                  ),
                ),
              ),
    );
  }
}
