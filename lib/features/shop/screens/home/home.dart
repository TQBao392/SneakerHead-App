import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sneakerhead/features/shop/screens/home/widgets/home_categories.dart';
import 'package:sneakerhead/utils/device/device_utility.dart';
import 'package:sneakerhead/utils/helpers/helper_functions.dart';
import '../../../../common/widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../../common/widgets/custom_shapes/containers/search_container.dart';
import '../../../../common/widgets/image_text_widgets/vertical_imge_text.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import 'widgets/home_appbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  get showBackground => null;

  get showBorder => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TPrimaryHeaderContainer(
              child: Column(
                children: [
                  THomeAppBar(),
                  SizedBox(height: TSizes.spaceBtwSections),

                  TSearchContainer(text: 'Search in Store', showBackground: showBackground, showBorder: showBorder),
                  SizedBox(height: TSizes.spaceBtwSections),

                  Padding(padding: EdgeInsets.only(left: TSizes.defaultSpace),
                    child: Column(
                      children: [
                        TSectionHeading(title: 'Popular Categories', showActionButton: false, textColor: Colors.white,),
                        SizedBox(height: TSizes.spaceBtwItems),

                        THomeCategories()
                      ],
                    ),
                  )
                ],
              )
            ),
          ],
        ),
      ),
    );
  }
}





