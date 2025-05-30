import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Checkout Flow',
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.light(primary: Colors.black),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle:
          TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0A84FF),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      ),
      routes: {
        '/': (_) => const CheckoutScreen(),
        '/success': (_) => const PaymentSuccessScreen(),
      },
    );
  }
}

class CartItem {
  final String brand;
  final String title;
  final String details;
  final double price;
  final int quantity;

  CartItem({
    required this.brand,
    required this.title,
    required this.details,
    required this.price,
    required this.quantity,
  });
}

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});
  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  List<CartItem> items = [];
  double subtotal = 0.0;
  double shippingFee = 0.0;
  double taxFee = 0.0;
  double promoDiscount = 0.0;
  bool isLoading = true;
  String? errorMessage;
  final promoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  // Mock data fetching function (replace with real API call if needed)
  Future<void> fetchData() async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        items = [
          CartItem(
            brand: 'Nike',
            title: 'Black Sports Shoes',
            details: 'Color Green   Size UK 08',
            price: 256.0,
            quantity: 2,
          ),
          CartItem(
            brand: 'Adidas',
            title: 'White Sneakers',
            details: 'Color White   Size UK 09',
            price: 199.0,
            quantity: 1,
          ),
        ];
        subtotal = items.fold(0, (sum, item) => sum + item.price * item.quantity);
        shippingFee = 6.0;
        taxFee = 6.0;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to load data: $e';
        isLoading = false;
      });
    }
  }

  void applyPromo() {
    if (promoController.text.trim().toUpperCase() == 'SAVE10') {
      setState(() {
        promoDiscount = 10.0;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid promo code')),
      );
    }
  }

  double get orderTotal => subtotal + shippingFee + taxFee - promoDiscount;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (errorMessage != null) {
      return Scaffold(
        body: Center(child: Text(errorMessage!)),
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Checkout'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: [
          ...items.map((item) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      'https://placehold.co/60x60/png?text=Shoes',
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 60,
                          height: 60,
                          color: Colors.grey,
                          child: const Icon(Icons.error, color: Colors.red),
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
                              style: const TextStyle(fontWeight: FontWeight.bold),
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
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(item.title),
                        const SizedBox(height: 4),
                        Text(
                          '${item.details}   Quantity: ${item.quantity}',
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text('\$${(item.price * item.quantity).toStringAsFixed(0)}'),
                ],
              ),
            );
          }),
          // Promo code
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: promoController,
                    decoration: InputDecoration(
                      hintText: 'Have a promo code? Enter here',
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: applyPromo,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                      side: const BorderSide(color: Colors.grey),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                  child: const Text('Apply'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Summary fees
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                _buildFeeRow('Subtotal', subtotal),
                _buildFeeRow('Shipping Fee', shippingFee),
                _buildFeeRow('Tax Fee', taxFee),
                if (promoDiscount > 0) _buildFeeRow('Discount', -promoDiscount),
                const Divider(),
                _buildFeeRow('Order Total', orderTotal, isTotal: true),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Payment Method
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Payment Method',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextButton(
                onPressed: () {
                  // TODO: change payment
                },
                child: const Text('Change'),
              ),
            ],
          ),
          Row(
            children: [
              Image.network(
                'https://via.placeholder.com/32x32.png?text=PayPal',
                width: 32,
                height: 32,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.payment, size: 32, color: Colors.grey);
                },
              ),
              const SizedBox(width: 8),
              const Text('Paypal'),
            ],
          ),
          const SizedBox(height: 24),
          // Shipping Address
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Shipping Address',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextButton(
                onPressed: () {
                  // TODO: change address
                },
                child: const Text('Change'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text('Coding with T'),
          const SizedBox(height: 4),
          Row(
            children: const [
              Icon(Icons.phone, size: 16, color: Colors.grey),
              SizedBox(width: 4),
              Text('+92-317-8059525', style: TextStyle(color: Colors.grey)),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: const [
              Icon(Icons.location_on, size: 16, color: Colors.grey),
              SizedBox(width: 4),
              Expanded(
                  child: Text('South Liana, Maine 87695, USA',
                      style: TextStyle(color: Colors.grey))),
            ],
          ),
          const SizedBox(height: 32),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/success');
          },
          child: Text('Checkout \$${orderTotal.toStringAsFixed(1)}'),
        ),
      ),
    );
  }

  Widget _buildFeeRow(String label, double value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
                fontWeight: isTotal ? FontWeight.bold : FontWeight.normal),
          ),
          Text(
            '\$${value.toStringAsFixed(1)}',
            style: TextStyle(
                fontWeight: isTotal ? FontWeight.bold : FontWeight.normal),
          ),
        ],
      ),
    );
  }
}

class PaymentSuccessScreen extends StatelessWidget {
  const PaymentSuccessScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: const BoxDecoration(
                  color: Color(0xFFE6F7FF),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle_outline,
                  size: 80,
                  color: Color(0xFF0A84FF),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Payment Success!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Your item will be shipped soon!',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  Navigator.popUntil(context, ModalRoute.withName('/'));
                },
                child: const Text('Continue'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}