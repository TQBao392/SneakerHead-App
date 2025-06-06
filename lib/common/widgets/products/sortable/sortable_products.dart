import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sneakerhead/features/shop/controllers/all_products_controller.dart';
import 'package:sneakerhead/features/shop/models/product_model.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../common/widgets/products/product_cards/product_card_vertical.dart';
import '../../../../utils/constants/sizes.dart';

class TSortableProduct extends StatelessWidget {
  const TSortableProduct({super.key, required this.products});

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    // Initialize controller for managing product sorting
    final controller = Get.put(AllProductsController());
    controller.assignProducts(products);
    return Column(
      children: [
        /// Dropdown
        DropdownButtonFormField(
          decoration: InputDecoration(prefixIcon: Icon(Iconsax.sort)),
          value: controller.selectedSortOption.value,
          onChanged: (value) {
            // Sort products based on the selected option
            controller.sortProducts(value!);
          },
          items:
              [
                    'Name',
                    'Higher Price',
                    'Lower Price',
                    'Sale',
                    'Newest',
                    'Popularity',
                  ]
                  .map(
                    (option) =>
                        DropdownMenuItem(value: option, child: Text(option)),
                  )
                  .toList(),
        ),
        SizedBox(height: TSizes.spaceBtwSections),

        /// Products
        Obx(
          () => TGridLayout(
            itemCount: controller.products.length,
            itemBuilder:
                (_, index) =>
                    TProductCardVertical(product: controller.products[index]),
          ),
        ),
      ],
    );
  }
}
