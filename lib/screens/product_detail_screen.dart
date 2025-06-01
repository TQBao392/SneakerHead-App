import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:t_store/screens/cart/cart_screen.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class ProductDetailScreen extends StatelessWidget {
  final Map<String, dynamic> product;
  final List<CartItem> cartItems;

  const ProductDetailScreen({
    super.key,
    required this.product,
    required this.cartItems,
  });

  void _addToCart(BuildContext context) {
    final title = product['name'] ?? 'Unknown';
    final existingIndex = cartItems.indexWhere((item) => item.title == title);

    if (existingIndex >= 0) {
      cartItems[existingIndex].quantity++;
    } else {
      cartItems.add(CartItem(
        brand: product['brand'] ?? 'No Brand',
        title: title,
        imageUrl: product['imageUrl'] ?? '',
        price: (product['price'] as num?)?.toDouble() ?? 0.0,
        quantity: 1,
      ));
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$title added to cart')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final String title = product['name'] ?? 'No name';
    final String brand = product['brand'] ?? 'No brand';
    final double price = (product['price'] as num?)?.toDouble() ?? 0.0;
    final String imageUrl = product['imageUrl'] ?? '';
    final String description = product['description'] ?? 'No description available.';
    final int stock = (product['stock'] as num?)?.toInt() ?? 0;

    return Scaffold(
      appBar: AppBar(
        title: Text('$brand - $title'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartScreen(cartItems: cartItems),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Container(
              height: 300,
              width: double.infinity,
              color: dark ? TColors.dark : TColors.light,
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.contain,
                placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey[300],
                  child: const Icon(
                    Icons.broken_image,
                    size: 60,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            // Product Details
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    title,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems / 2),
                  // Brand
                  Text(
                    brand,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  // Price
                  Text(
                    '${price.toStringAsFixed(2)}₫',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: TColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  // Stock Status
                  Text(
                    stock > 0 ? 'In Stock: $stock units' : 'In Stock',
                    style: TextStyle(
                      color: stock > 0 ? Colors.green : Colors.red,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  // Description
                  Text(
                    'Description',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems / 2),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems * 2),
                  // Add to Cart Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => _addToCart(context), // Always enabled
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: TColors.primary, // Consistent color
                      ),
                      child: const Text(
                        'Add to Cart',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
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