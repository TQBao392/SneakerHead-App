import 'package:flutter/material.dart';

void main() {
  runApp(const SneakerApp());
}

class SneakerApp extends StatelessWidget {
  const SneakerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sneaker Cart',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF181818),
        cardColor: const Color(0xFF252525),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFFF3D00),
          secondary: Color(0xFF757575),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          bodyMedium: TextStyle(fontSize: 14),
          bodySmall: TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ),
      home: const CartPage(),
    );
  }
}

class CartItem {
  final String brand;
  final String model;
  final String details;
  final double price;
  int quantity;

  CartItem({
    required this.brand,
    required this.model,
    required this.details,
    required this.price,
    required this.quantity,
  });
}

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final List<CartItem> _cartItems = [
    CartItem(
      brand: 'Nike',
      model: 'Air Force 1',
      details: 'Color: White, Size: US 9',
      price: 100.0,
      quantity: 1,
    ),
    CartItem(
      brand: 'Adidas',
      model: 'Yeezy Boost 350',
      details: 'Color: Black, Size: US 8.5',
      price: 220.0,
      quantity: 2,
    ),
    CartItem(
      brand: 'Puma',
      model: 'Suede Classic',
      details: 'Color: Navy, Size: US 10',
      price: 80.0,
      quantity: 1,
    ),
    CartItem(
      brand: 'Converse',
      model: 'Chuck Taylor All Star',
      details: 'Color: Red, Size: US 7',
      price: 60.0,
      quantity: 3,
    ),
    CartItem(
      brand: 'Vans',
      model: 'Old Skool',
      details: 'Color: Black/White, Size: US 9.5',
      price: 70.0,
      quantity: 1,
    ),
  ];

  double get _totalPrice =>
      _cartItems.fold(0, (sum, item) => sum + item.price * item.quantity);

  void _incrementQuantity(int index) {
    setState(() {
      _cartItems[index].quantity++;
    });
  }

  void _decrementQuantity(int index) {
    setState(() {
      if (_cartItems[index].quantity > 1) {
        _cartItems[index].quantity--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
      ),
      body: _cartItems.isEmpty
          ? const Center(child: Text('Your cart is empty'))
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _cartItems.length,
        itemBuilder: (context, index) {
          final item = _cartItems[index];
          return ConstrainedBox(
            constraints: const BoxConstraints(
              minHeight: 120,
              minWidth: double.infinity,
            ),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              margin: const EdgeInsets.only(bottom: 12),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Brand and Model
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            '${item.brand} ${item.model}',
                            style: Theme.of(context).textTheme.bodyLarge,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          '\$${item.price.toStringAsFixed(0)}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                            fontWeight: FontWeight.bold,
                            color:
                            Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Details
                    Text(
                      item.details,
                      style: Theme.of(context).textTheme.bodySmall,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 12),
                    // Quantity and Total
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () => _decrementQuantity(index),
                              icon: const Icon(
                                  Icons.remove_circle_outline,
                                  size: 20),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '${item.quantity}',
                              style:
                              Theme.of(context).textTheme.bodyMedium,
                            ),
                            const SizedBox(width: 8),
                            IconButton(
                              onPressed: () => _incrementQuantity(index),
                              icon: const Icon(
                                  Icons.add_circle_outline,
                                  size: 20),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                          ],
                        ),
                        Text(
                          'Total: \$${(item.price * item.quantity).toStringAsFixed(0)}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: _cartItems.isEmpty
          ? null
          : Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: () {
            // Placeholder for checkout action
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Proceeding to checkout...')),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFF5722), // Vibrant orange
            padding: const EdgeInsets.symmetric(vertical: 24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            'PROCEED TO CHECKOUT - ${_totalPrice.toStringAsFixed(0)}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}