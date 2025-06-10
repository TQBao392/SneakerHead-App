import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sneakerhead/common/widgets/texts/section_heading.dart';
import 'package:sneakerhead/features/shop/models/payment_method_model.dart';
import 'package:sneakerhead/features/shop/screens/checkout/widgets/payment_tile.dart';
import 'package:sneakerhead/utils/constants/image_strings.dart';
import 'package:sneakerhead/utils/constants/sizes.dart';

class CheckoutController extends GetxController {
  static CheckoutController get instance => Get.find();

  final Rx<PaymentMethodModel> selectedPaymentMethodModel =
      PaymentMethodModel.empty().obs;

  @override
  void onInit() {
    selectedPaymentMethodModel.value = PaymentMethodModel(
      image: TImages.paypal,
      name: 'Paypal',
    );
    super.onInit();
  }

  Future<dynamic> showPaymentMethod(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (_) => SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(TSizes.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TSectionHeading(
                title: 'Select Payment Method',
                showActionButton: false,
              ),
              SizedBox(height: TSizes.spaceBtwSections),
              TPaymentTile(
                paymentMethod: PaymentMethodModel(
                  image: TImages.paypal,
                  name: 'Paypal',
                ),
              ),
              SizedBox(height: TSizes.spaceBtwSections / 2),
              TPaymentTile(
                paymentMethod: PaymentMethodModel(
                  image: TImages.googlePay,
                  name: 'Google Pay',
                ),
              ),
              SizedBox(height: TSizes.spaceBtwSections / 2),
              TPaymentTile(
                paymentMethod: PaymentMethodModel(
                  image: TImages.applePay,
                  name: 'Apple Pay',
                ),
              ),
              SizedBox(height: TSizes.spaceBtwSections / 2),
              TPaymentTile(
                paymentMethod: PaymentMethodModel(
                  image: TImages.visa,
                  name: 'VISA',
                ),
              ),
              SizedBox(height: TSizes.spaceBtwSections / 2),
              TPaymentTile(
                paymentMethod: PaymentMethodModel(
                  image: TImages.masterCard,
                  name: 'Master Card',
                ),
              ),
              SizedBox(height: TSizes.spaceBtwSections / 2),
              TPaymentTile(
                paymentMethod: PaymentMethodModel(
                  image: TImages.paytm,
                  name: 'Paytm',
                ),
              ),
              SizedBox(height: TSizes.spaceBtwSections / 2),
              TPaymentTile(
                paymentMethod: PaymentMethodModel(
                  image: TImages.paystack,
                  name: 'Paystack',
                ),
              ),
              SizedBox(height: TSizes.spaceBtwSections / 2),
              TPaymentTile(
                paymentMethod: PaymentMethodModel(
                  image: TImages.creditCard,
                  name: 'Credit Card',
                ),
              ),
              SizedBox(height: TSizes.spaceBtwSections),
            ],
          ),
        ),
      ),
    );
  }
}