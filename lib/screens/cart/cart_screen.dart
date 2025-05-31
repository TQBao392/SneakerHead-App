import 'package:flutter/material.dart';
import 'package:t_store/screens/all_products/all_products.dart';
import 'package:t_store/screens/cart/checkout_screen.dart';

class CartItem {
  final String brand;
  final String title;
  final String imageUrl;
  final double price;
  int quantity;

  CartItem({
    required this.brand,
    required this.title,
    required this.imageUrl,
    required this.price,
    this.quantity = 1,
  });
}

class CartScreen extends StatefulWidget {
  final List<CartItem> cartItems;

  const CartScreen({super.key, required this.cartItems});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double get totalPrice => widget.cartItems.fold(
    0,
        (sum, item) => sum + item.price * item.quantity,
  );

  void _increaseQuantity(int index) {
    setState(() {
      widget.cartItems[index].quantity++;
    });
  }

  void _decreaseQuantity(int index) {
    setState(() {
      if (widget.cartItems[index].quantity > 1) {
        widget.cartItems[index].quantity--;
      } else {
        widget.cartItems.removeAt(index);
      }
    });
  }

  void _goToCheckout() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CheckoutScreen(cartItems: widget.cartItems),
      ),
    );
  }

  void _continueShopping() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
      ),
      body: SafeArea(
        child: widget.cartItems.isEmpty
            ? const Center(child: Text('Your cart is empty'))
            : ListView.builder(
          itemCount: widget.cartItems.length,
          itemBuilder: (context, index) {
            final item = widget.cartItems[index];
            return ListTile(
              leading: Image.network(
                item.imageUrl,
                width: 50,
                height: 50,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
              ),
              title: Text(
                item.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.brand,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () => _decreaseQuantity(index),
                      ),
                      Text('${item.quantity}'),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () => _increaseQuantity(index),
                      ),
                    ],
                  ),
                ],
              ),
              trailing: Text(
                '\$${(item.price * item.quantity).toStringAsFixed(2)}',
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: widget.cartItems.isEmpty
          ? null
          : Container(
        padding: const EdgeInsets.all(16),
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Total: \$${totalPrice.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton(
                    onPressed: _continueShopping,
                    child: const Text('Continue Shopping'),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _goToCheckout,
                    child: const Text('Checkout'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}