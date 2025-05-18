import 'package:flutter/material.dart';
import 'package:sneakerhead/common/widgets/texts/section_heading.dart';
import 'package:sneakerhead/utils/constants/image_strings.dart';

import 'package:sneakerhead/common/widgets/appbar/appbar.dart';
import 'package:sneakerhead/common/widgets/images/t_rounded_image.dart';
import 'package:sneakerhead/utils/constants/sizes.dart';

class SubCategoriesScreen extends StatelessWidget {
  const SubCategoriesScreen({super.key});

  @override
  Widget build (BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(title: Text('Sports shirts'), showBackArrow: true),
      body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                  children: [
                    /// Banner
                    const TRoundedImage(width: double.infinity, imageUrl: TImages.promoBanner4, applyImageRadius: true),
                    const SizedBox(height: TSizes.spaceBtwSections),

                    /// Sub Categories
    Column(
    children: [
      /// Heading
    TSectionHeading(title: 'Sports shirts', onPressed: (){}),
    const SizedBox(height: TSizes.spaceBtwItems / 2),


    ],
    )
