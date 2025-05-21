import 'package:flutter/material.dart';
import 'package:sneakerhead/common/widgets/appbar/appbar.dart';
import 'package:sneakerhead/utils/constants/sizes.dart';
import 'package:sneakerhead/screens/sub_category/sub_categories.dart';

class AllProducts extends StatelessWidget {
  const AllProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: TAppBar(
        title: Text('All Products'),
        showBackArrow: true),
        body: SingleChildScrollView(
          child: Padding(padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              children: [
                /// Dropdown
                DropDownButtonFormField(
                  decoration: InputDecoration(prefixIcon: Icon(Iconsax.sort)),
                  onChanged: (value) {},
                  items: ['Name', 'Higher Price', 'Lower Price', 'Sale', 'Newest', 'Popularity']
                      .map((option) => DropdownMenuItem(value: option, child: Text(option)))
                      .toList(),
                ),
                const SizedBox(height: TSizes.spaceBtwSections),
                /// Products
                TGridLayout()
              ],
            ),
            ),
        ),
    );
  }
}