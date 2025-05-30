import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CartItem {
  final String brand;
  final String title;
  final String details;
  final double price;
  int quantity;

  CartItem({
    required this.brand,
    required this.title,
    required this.details,
    required this.price,
    this.quantity = 1,
  });
}

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final List<CartItem> _items = [
    CartItem(
      brand: 'Nike',
      title: 'Air Max 270',
      details: 'Color Black   Size UK 08',
      price: 150.0,
      quantity: 2,
    ),
    CartItem(
      brand: 'Adidas',
      title: 'Ultraboost 22',
      details: 'Color White   Size UK 09',
      price: 180.0,
      quantity: 1,
    ),
    CartItem(
      brand: 'Puma',
      title: 'RS-X Reinvention',
      details: 'Color Grey   Size UK 07',
      price: 120.0,
      quantity: 1,
    ),
  ];

  double get _totalPrice =>
      _items.fold(0, (sum, item) => sum + item.price * item.quantity);

  void _increment(int index) {
    setState(() {
      _items[index].quantity++;
    });
  }

  void _decrement(int index) {
    setState(() {
      if (_items[index].quantity > 1) {
        _items[index].quantity--;
      }
    });
  }

  void _removeItem(int index) {
    setState(() {
      _items.removeAt(index);
    });
  }

  void _addItem() {
    setState(() {
      _items.add(
        CartItem(
          brand: 'New Balance',
          title: 'Fresh Foam 1080',
          details: 'Color Blue   Size UK 08',
          price: 160.0,
          quantity: 1,
        ),
      );
    });
  }

  void _navigateToCheckout() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CheckoutScreen(items: _items),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
        title: const Text('Cart'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.of(context).maybePop();
          },
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: _items.length,
        separatorBuilder: (_, __) => const SizedBox(height: 4),
        itemBuilder: (context, index) {
          final item = _items[index];
          return Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    'https://picsum.photos/60/60?random=$index',
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      if (kDebugMode) {
                        print('Image load error for ${item.title}: $error');
                      }
                      return Container(
                        width: 60,
                        height: 60,
                        color: Colors.grey,
                        child: const Icon(Icons.broken_image, color: Colors.red),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            item.brand,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Color(0xFF0A84FF),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () => _removeItem(index),
                            icon: const Icon(Icons.delete, color: Colors.red),
                            tooltip: 'Remove',
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.title,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 1,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.details,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 1,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          InkWell(
                            onTap: () => _decrement(index),
                            borderRadius: BorderRadius.circular(4),
                            child: const Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Icon(Icons.remove, size: 20),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '${item.quantity}',
                            style: const TextStyle(fontSize: 14),
                          ),
                          const SizedBox(width: 6),
                          InkWell(
                            onTap: () => _increment(index),
                            borderRadius: BorderRadius.circular(4),
                            child: const Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Icon(Icons.add, size: 20),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '\$${(item.price * item.quantity).toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.white,
        child: ElevatedButton(
          onPressed: _navigateToCheckout,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0A84FF),
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            'Checkout \$${_totalPrice.toStringAsFixed(1)}',
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addItem,
        backgroundColor: const Color(0xFF0A84FF),
        child: const Icon(Icons.add_shopping_cart),
      ),
    );
  }
}

class CheckoutScreen extends StatelessWidget {
  final List<CartItem> items;

  const CheckoutScreen({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: Center(
        child: Text('Checkout with ${items.length} items'),
      ),
    );
  }
}