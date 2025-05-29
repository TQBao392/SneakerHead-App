import 'package:flutter/material.dart';
import 'package:sneakerhead/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:sneakerhead/common/widgets/products.cart/cart_menu_icon.dart';
import 'package:sneakerhead/common/widgets/appbar/appbar.dart';
import 'package:sneakerhead/utils/constants/colors.dart';
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
                children: const [
                  /// -- Search bar
                  SizedBox(height: TSizes.spaceBtwItems),
                  TSearchContainer(text: 'Tìm kiếm', showBorder: true, showBackground: false, padding: EdgeInsets.zero),
                  SizedBox(height: TSizes.spaceBtwSections),

                ]
              )
            )
          ),
        ];
      }, body: Container()),
    );
  }
}
