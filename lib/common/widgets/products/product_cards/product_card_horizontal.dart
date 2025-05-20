import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sneakerhead/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:sneakerhead/common/widgets/images/t_rounded_image.dart';
import 'package:sneakerhead/common/widgets/t_circular_icon.dart';
import 'package:sneakerhead/utils/constants/colors.dart';
import 'package:sneakerhead/utils/constants/image_strings.dart';
import 'package:sneakerhead/utils/constants/sizes.dart';
import 'package:sneakerhead/utils/helpers/helper_functions.dart';

class TProductCardHorizontal extends StatelessWidget {
  const TProductCardHorizontal({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode (context);

    return Container(
      width: 310,
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        boxShadow: [TShadowStyle.verticalProductShadow],
        borderRadius: BorderRadius.circular (TSizes.productImageRadius),
        color: dark? TColors.darkerGrey:TColors.white,
      ),
      child: Row(
        children: [
          /// Thumbnail
          TRoundedContainer(
            height: 120,
            padding: const EdgeInsets.all(TSizes.sm),
            backgroundColor: dark ? TColors.dark : TColors.light,
            child: const Stack(
                children: [
                  /// - Thumbnail Image
                  SizedBox(
                  height: 120,
                  width: 120,
                  child: TRoundedImage(imageUrl: TImages.productImage1, applyImageRadius: true),
                  ),

                  /// - Sale Tag
                  Positioned(
                  top: 12,
                    child: TRoundedContainer(
                          radius: TSizes.sm,
                          backgroundColor: TColors.secondary.withOpacity(0.8),
                          padding: const EdgeInsets.symmetric(horizontal: TSizes.sm, vertical: TSizes.xs),
                          child: Text(
                              '25%',
                              style: Theme.of(context).textTheme.labelLarge?.apply(color: TColors.black),
                          ),
                        ),
                  ),

                  /// - Favourite Icon Button
                  Positioned(
                      top: 0,
                      right: 0,
                      child: TCircularIcon(icon: Iconsax.heart5, color: Colors.red),
                  ),
                ]
            ),
          ),

          /// Details
          const SizedBox(
            width: 172,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Column(
                  children: [
                    TProductTitleText(
                      title: 'Nike Air Max 270 React',
                      smallSize: true),
                    SizedBox(height: TSizes.spaceBtwItems /2),
                    TBrandTitleWithVerifiedIcon(title: 'Nike'),
                  ],
                                  ),
                    Row(
                      children: [
                        /// Pricing
                        TProductPriceText(price: '256.0'),


                        /// Add to cart
                      ],
                    )
              ),
            ),
          )
        ],
      ),
    );
  }
}