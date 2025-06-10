import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sneakerhead/features/shop/models/product_model.dart';
import 'package:sneakerhead/utils/constants/sizes.dart';

class ImagesController extends GetxController {
  static ImagesController get instance => Get.find();

  /// Observable selected image
  RxString selectedProductImage = ''.obs;

  /// Get all product image URLs (thumbnail, gallery, variations)
  List<String> getAllProductImages(ProductModel product) {
    Set<String> images = {};

    // Add main thumbnail
    if (product.thumbnail.isNotEmpty) {
      images.add(product.thumbnail);
      selectedProductImage.value = product.thumbnail;
    }

    // Add product gallery images
    if (product.images != null && product.images!.isNotEmpty) {
      images.addAll(product.images!);
    }

    // Add variation images
    if (product.productVariations != null && product.productVariations!.isNotEmpty) {
      images.addAll(
        product.productVariations!
            .map((variation) => variation.image)
            .where((image) => image.isNotEmpty),
      );
    }

    return images.toList();
  }

  /// Show fullscreen image popup
  void showEnlargedImage(String imageUrl) {
    Get.to(
      fullscreenDialog: true,
          () => Dialog.fullscreen(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: TSizes.defaultSpace * 2,
                horizontal: TSizes.defaultSpace,
              ),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                placeholder: (context, url) =>
                const CircularProgressIndicator(),
                errorWidget: (context, url, error) =>
                const Icon(Icons.error_outline),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwSections),
            SizedBox(
              width: 150,
              child: OutlinedButton(
                onPressed: () => Get.back(),
                child: const Text('Close'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
