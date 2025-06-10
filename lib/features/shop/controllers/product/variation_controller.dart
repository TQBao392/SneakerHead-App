import 'package:get/get.dart';
import 'package:sneakerhead/features/shop/controllers/product/cart_controller.dart';
import 'package:sneakerhead/features/shop/controllers/product/images_controller.dart';
import 'package:sneakerhead/features/shop/models/product_model.dart';
import 'package:sneakerhead/features/shop/models/product_variation_model.dart';

class VariationController extends GetxController {
  static VariationController get instance => Get.find();

  /// Variables
  RxMap selectedAttributes = {}.obs;
  RxString variationStockStatus = ''.obs;
  Rx<ProductVariationModel> selectedVariation =
      ProductVariationModel.empty().obs;

  /// -- Select Attribute, and Variation
  void onAttributeSelected(
    ProductModel product,
    attributeName,
    attributeValue,
  ) {
    // When attributes is selected we will first add that attribute to the selectedAttributes
    final selectedAttributes = Map<String, dynamic>.from(
      this.selectedAttributes,
    );
    selectedAttributes[attributeName] = attributeValue;
    this.selectedAttributes[attributeName] = attributeValue;

    final selectedVariation = product.productVariations!.firstWhere(
      (variation) =>
          _isSameAttributeValues(variation.attributeValues, selectedAttributes),
      orElse: () => ProductVariationModel.empty(),
    );

    // Show the selected Variation image as a Main Image
    if (selectedVariation.image.isNotEmpty) {
      ImagesController.instance.selectedProductImage.value =
          selectedVariation.image;
    }

    // Show selected variation quantity already in the cart.
    if (selectedVariation.id.isNotEmpty) {
      final cartController = CartController.instance;
      cartController.productQuantityInCart.value = cartController
          .getVariationQuantityInCart(product.id, selectedVariation.id);
    }

    // Assign Selected Variation
    if (selectedVariation.id.isNotEmpty) {
      // Assign Selected Variation
      this.selectedVariation.value = selectedVariation;

      // Update stock status
      getProductVariationStockStatus();
    } else {
      // No valid variation found for selected attributes
      this.selectedVariation.value = ProductVariationModel.empty();
      variationStockStatus.value = 'Unavailable';
    }

  }

  /// -- Check If selected attributes matches any variation attributes
  bool _isSameAttributeValues(
    Map<String, dynamic> variationAttributes,
    Map<String, dynamic> selectedAttributes,
  ) {
    // If selectedAttributes cotain 3 attributes and current variation contains 2 then return
    if (variationAttributes.length != selectedAttributes.length) return false;

    // If any of the attributes is different then return. e.g. [Green, Large] x [Green, Small]
    for (final key in variationAttributes.keys) {
      // Attributes[Key] = Value which could be [Green, Small, Cotton] etc.
      if (variationAttributes[key] != selectedAttributes[key]) return false;
    }

    return true;
  }

  /// -- Check Attribute availability / Stock in Variation
  Set<String?> getAttributesAvailabilityInVariation(
    List<ProductVariationModel> variations,
    String attributeName,
  ) {
    // Pass the variations to check which attributes are available and stock is not 0
    final availableVariationAttributeValues =
        variations
            .where(
              (variation) =>
                  variation.attributeValues[attributeName] != null &&
                  variation.attributeValues[attributeName]!.isNotEmpty &&
                  variation.stock > 0,
            )
            .map((variation) => variation.attributeValues[attributeName])
            .toSet();
    return availableVariationAttributeValues;
  }

  String getVariationPrice() {
    return (selectedVariation.value.salePrice > 0
            ? selectedVariation.value.salePrice
            : selectedVariation.value.price)
        .toString();
  }

  /// -- Check Product Variation Stock Status
  void getProductVariationStockStatus() {
    variationStockStatus.value =
        selectedVariation.value.stock > 0 ? 'In Stock' : 'Out of Stock';
  }

  /// -- Reset Selected Attributes when switching products
  void resetSelectedAttributes() {
    selectedAttributes.clear();
    variationStockStatus.value = '';
    selectedVariation.value = ProductVariationModel.empty();
  }
}
