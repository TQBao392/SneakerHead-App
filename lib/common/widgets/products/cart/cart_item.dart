import 'package:flutter/material.dart';
import 'package:sneakerhead/common/widgets/images/t_rounded_image.dart';
import 'package:sneakerhead/common/widgets/texts/product_tittle_text.dart';
import 'package:sneakerhead/common/widgets/texts/t_brand_title_text_with_verified_icon.dart';
import 'package:sneakerhead/features/shop/models/cart_item_model.dart';
import 'package:sneakerhead/utils/constants/colors.dart';
import 'package:sneakerhead/utils/constants/sizes.dart';
import 'package:sneakerhead/utils/helpers/helper_functions.dart';

class TCartItem extends StatelessWidget {
  const TCartItem({super.key, required this.cartItem});

  final CartItemModel cartItem;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        /// Image
        TRoundedImage(
          imageUrl: cartItem.image ?? '',
          width: 60,
          height: 60,
          padding: const EdgeInsets.all(TSizes.sm),
          backgroundColor:
              THelperFunctions.isDarkMode(context)
                  ? TColors.darkerGrey
                  : TColors.light,
        ),
        const SizedBox(width: TSizes.spaceBtwItems),

        /// Title, Price & Size
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TBrandTitleTextWithVerifiedIcon(title: cartItem.brandName ?? ''),
              Flexible(
                child: TProductTitleText(title: cartItem.title, maxLines: 1),
              ),
              Text.rich(
                TextSpan(
                  children:
                      (cartItem.selectedVariation ?? {}).entries
                          .map(
                            (e) => TextSpan(
                              children: [
                                TextSpan(
                                  text: ' ${e.key}',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                TextSpan(
                                  text: '${e.value} ',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ],
                            ),
                          )
                          .toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
