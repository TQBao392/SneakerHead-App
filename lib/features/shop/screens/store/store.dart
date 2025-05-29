import 'package:flutter/material.dart';
import 'package:sneakerhead/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:sneakerhead/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:sneakerhead/common/widgets/images/t_circular_image.dart';
import 'package:sneakerhead/common/widgets/layouts/grid_layout.dart';
import 'package:sneakerhead/common/widgets/products.cart/cart_menu_icon.dart';
import 'package:sneakerhead/common/widgets/appbar/appbar.dart';
import 'package:sneakerhead/common/widgets/texts/section_heading.dart';
import 'package:sneakerhead/common/widgets/texts/t_brand_title_text_with_verified_icon.dart';
import 'package:sneakerhead/utils/constants/colors.dart';
import 'package:sneakerhead/utils/constants/enums.dart';
import 'package:sneakerhead/utils/constants/image_strings.dart';
import 'package:sneakerhead/utils/constants/sizes.dart';
import 'package:sneakerhead/utils/helpers/helper_functions.dart';
class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: Text('Store', style: Theme.of(context).textTheme.headlineMedium),
        actions: [
          TCartCounterIcon(onPressed: (){})
        ],
      ),
      body: NestedScrollView(headerSliverBuilder: (_, innerBoxIsScrolled){
        return [
          SliverAppBar(
            automaticallyImplyLeading: false,
            pinned: true,
            floating: true,
            backgroundColor: THelperFunctions.isDarkMode(context) ? TColors.black : TColors.white,
            expandedHeight: 440,

            flexibleSpace: Padding(
              padding: EdgeInsets.all(TSizes.defaultSpace),
              child: ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  /// -- Search bar
                  const SizedBox(height: TSizes.spaceBtwItems),
                  const TSearchContainer(text: 'Search Product', showBorder: true, showBackground: false, padding: EdgeInsets.zero),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  /// -- Featured Brands
                  TSectionHeading(title: ' Featured Brands', onPressed: (){}),
                  const SizedBox(height: TSizes.spaceBtwItems / 1.5),

                  TGridLayout(itemCount: 4, mainAxisExtent: 80 ,itemBuilder: (_, index) {
                    return GestureDetector(
                      onTap: (){},
                      child: TRoundedContainer(
                        padding: const EdgeInsets.all(TSizes.sm),
                        showBorder: true,
                        backgroundColor: Colors.transparent,
                        child: Row(
                          children: [
                            /// -- Icon
                            Flexible(
                              child: TCircularImage(
                                isNetworkImage: false,
                                image: TImages.clothIcon,
                                backgroundColor: Colors.transparent,
                                overlayColor: THelperFunctions.isDarkMode(context) ? TColors.white : TColors.black,
                              ),
                            ),
                            const SizedBox(width: TSizes.spaceBtwItems / 2),
                    
                            /// -- Text
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const TBrandTitleTextWithVerifiedIcon(title: 'Nike', brandTextSize: TextSizes.large,),
                                  Text(
                                    '256 products',
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context).textTheme.labelMedium,
                                  ),
                                ],
                                                         ),
                            )
                         ],
                        ),
                      ),
                    );
                   })

                 ]
              )
            )
          ),
        ];
      }, body: Container()),
    );
  }
}
