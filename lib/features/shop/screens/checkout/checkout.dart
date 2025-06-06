import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sneakerhead/common/widgets/appbar/appbar.dart';
import 'package:sneakerhead/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:sneakerhead/common/widgets/products/cart/coupon_widget.dart';

import 'package:sneakerhead/features/shop/controllers/product/cart_controller.dart';
import 'package:sneakerhead/features/shop/controllers/product/order_controller.dart';
import 'package:sneakerhead/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:sneakerhead/features/shop/screens/checkout/widgets/billing_address_section.dart';
import 'package:sneakerhead/features/shop/screens/checkout/widgets/billing_amount_section.dart';
import 'package:sneakerhead/features/shop/screens/checkout/widgets/billing_payment_section.dart';

import 'package:sneakerhead/utils/constants/colors.dart';

import 'package:sneakerhead/utils/constants/sizes.dart';
import 'package:sneakerhead/utils/helpers/helper_functions.dart';
import 'package:sneakerhead/utils/helpers/pricing_calculator.dart';
import 'package:sneakerhead/utils/popups/loaders.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    final subTotal = cartController.totalCartPrice.value;
    final orderController = Get.put(OrderController());
    final totalAmount = TPricingCalculator.calculateTotalPrice(subTotal, 'US');
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          'Order Review',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// -- Items in Cart
              const TCartItems(showAddRemoveButton: false),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// --Coupon TextField
              const TCouponCode(),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// --Billings Section
              TRoundedContainer(
                showBorder: true,
                padding: const EdgeInsets.all(TSizes.md),
                backgroundColor: dark ? TColors.black : TColors.white,
                child: Column(
                  children: [
                    /// Pricing
                    TBillingAmountSection(),
                    const SizedBox(height: TSizes.spaceBtwItems),

                    /// Divider
                    const Divider(),
                    const SizedBox(height: TSizes.spaceBtwItems),

                    /// Payment Methods
                    TBillingPaymentSection(),
                    const SizedBox(height: TSizes.spaceBtwItems),

                    /// Address
                    TBillingAddressSection(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      /// Checkout Button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: ElevatedButton(
          onPressed:
              subTotal > 0
                  ? () => orderController.processOrder(totalAmount)
                  : () => TLoaders.warningSnackBar(
                    title: 'Empty Cart',
                    message: 'Add items in the cart in order to proceed',
                  ),
          child: Text('Checkout \$$totalAmount'),
        ),
      ),
    );
  }
}
