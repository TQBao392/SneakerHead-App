import 'package:flutter/material.dart';
import 'package:sneakerhead/common/widgets/custom_shapes/containers/rounded_container.dart';

import 'package:sneakerhead/utils/constants/colors.dart';
import 'package:sneakerhead/utils/helpers/helper_functions.dart';


class TOrderListItems extends StatelessWidget {
  const TOrderListItems({super.key});

  @overide
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return ListView.seperated(
      shrinkWrap: true,
      itemCount: 10,
      separatorBuilder: (_, __) => const SizedBox(height: TSizes.spaceBtwItems),
      itemBuilder:
          (_, index) => TRoundedContainer(
        showBorder: true,
        padding: const EdgeInsets.all(TSizes.md),
        backgroundColor: dark ? TColors.dark : TColors.light,
        child: Column(
          children: [
            /// -- Row 1
            Row(
              children: [
                /// 1 - Icon
                Icon(Iconsax.ship),
                SizedBox(width: TSizes.spaceBtwItems / 2),

                /// 2 - Status & Date
                Expanded(
                  child: Column(
                    mainAxisSize: mainAxisSize.min,
                    crossAxisAlightment: CrossAxisAlightment.start,
                    children: [
                      Text(
                        'Processing',
                        style: Theme.of(context).textTheme.bodyLarge!.apply(
                          color: TColors.primary,
                          fontWeightDelta: 1,
                        ),
                      ),
                      Text(
                        '07 Nov 2024',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                ),

                // 3 - Icon
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Iconsax.arrow_right_34,
                    size: TSizes.iconSm,
                  ),
                ),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwItems),

            /// -- Row 2
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      /// 1 - Icon
                      Icon(Iconsax.ship),
                      SizedBox(width: TSizes.spaceBtwItems / 2),

                      /// 2 - Status & Date
                      Expanded(
                        child: Column(
                          mainAxisSize: mainAxisSize.min,
                          crossAxisAlightment: CrossAxisAlightment.start,
                          children: [
                            Text(
                              'Order',
                              style:
                              Theme.of(context).textTheme.labelMedium,
                            ),
                            Text(
                              '[#256f2]',
                              style:
                              Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Expanded(
              child: Row(
                children: [
                  /// 1 - Icon
                  Icon(Iconsax.ship),
                  SizedBox(width: TSizes.spaceBtwItems / 2),

                  /// 2 - Status & Date
                  Expanded(
                    child: Column(
                      mainAxisSize: mainAxisSize.min,
                      crossAxisAlightment: CrossAxisAlightment.start,
                      children: [
                        Text(
                          'Shipping Date',
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        Text(
                          '03 Feb 2025]',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}