import 'package:flutter/material.dart';
import 'package:t_store/screens/cart/cart_screen.dart';
import '../all_products/all_products.dart';

class CheckoutScreen extends StatefulWidget {
  final List<CartItem> cartItems;

  const CheckoutScreen({super.key, required this.cartItems});

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}
 class _CheckoutScreenState extends State<CheckoutScreen> {
  String _selectedPaymentMethod = 'Credit Card';
  String? _promoCode;
  bool _isLoading = false;
  final double deliveryFee = 10;
  final String userAddress = '123 Main St, City, Country 12345';
  final List<String> paymentMethods = [
    'Credit Card',
    'PayPal',
    'Apple Pay',
    'Cash on Delivery'
  ];
  final TextEditingController _promoController = TextEditingController();

  double get subtotal =>
      widget.cartItems.fold(0, (sum, item) => sum + item.price * item.quantity);

  double get discount => _promoCode == 'SAVE10' ? subtotal * 0.1 : 0;

  void _applyPromoCode() {
    setState(() {
      _promoCode = _promoController.text.trim().toUpperCase();
      if (_promoCode != 'SAVE10') {
        _promoCode = null;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid promo code')),
        );
      }
    });
  }

  void _placeOrder(BuildContext context) async {
    if (widget.cartItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Your cart is empty')),
      );
      return;
    }

    setState(() => _isLoading = true);

    // Simulate network request
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Confirm Order'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Total: \$${((subtotal + deliveryFee) - discount).toStringAsFixed(2)}'),
              Text('Items: ${widget.cartItems.length}'),
              Text('Payment: $_selectedPaymentMethod'),
              Text('Address: $userAddress'),
              if (_promoCode != null) Text('Promo: $_promoCode'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Order #${DateTime.now().millisecondsSinceEpoch % 10000} placed successfully!'),
                  ),
                );
                Navigator.pop(context);
              },
              child: const Text('Confirm'),
            ),
          ],
        ),
      );
      setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _promoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double total = (subtotal + deliveryFee) - discount;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Contact support: support@example.com')),
              );
            },
          ),
        ],
      ),
      body: widget.cartItems.isEmpty
          ? const Center(child: Text('Your cart is empty', style: TextStyle(fontSize: 18)))
          : SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Order Summary'),
            _buildCartItemsList(),
            _buildSectionTitle('Delivery Address'),
            _buildAddressSection(),
            _buildSectionTitle('Promo Code'),
            _buildPromoCodeSection(),
            _buildSectionTitle('Payment Method'),
            _buildPaymentMethodSection(),
            _buildSummarySection(total),
            _buildPlaceOrderButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildCartItemsList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.cartItems.length,
      itemBuilder: (context, index) {
        final item = widget.cartItems[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          elevation: 2,
          child: ListTile(
            contentPadding: const EdgeInsets.all(12),
            leading: Image.network(
              item.imageUrl,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.broken_image,
                size: 60,
                color: Colors.grey,
              ),
            ),
            title: Text(
              item.title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(
                  item.brand,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
                Text(
                  'Qty: ${item.quantity} × \$${item.price.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
            trailing: Text(
              '\$${(item.price * item.quantity).toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAddressSection() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                userAddress,
                style: const TextStyle(fontSize: 16, color: Colors.black87),
              ),
            ),
            TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Address change not implemented')),
                );
              },
              child: const Text(
                'Change',
                style: TextStyle(fontSize: 16, color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPromoCodeSection() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _promoController,
                decoration: const InputDecoration(
                  labelText: 'Enter promo code',
                  border: OutlineInputBorder(),
                ),
                onSubmitted: (_) => _applyPromoCode(),
              ),
            ),
            const SizedBox(width: 12),
            ElevatedButton(
              onPressed: _applyPromoCode,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              child: const Text('Apply'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethodSection() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            isExpanded: true,
            value: _selectedPaymentMethod,
            items: paymentMethods
                .map((method) => DropdownMenuItem(
              value: method,
              child: Text(
                method,
                style: const TextStyle(fontSize: 16),
              ),
            ))
                .toList(),
            onChanged: (value) {
              if (value != null) {
                setState(() => _selectedPaymentMethod = value);
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSummarySection(double total) {
    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSummaryRow('Subtotal (${widget.cartItems.length} items)', subtotal),
            _buildSummaryRow('Delivery Fee', deliveryFee),
            if (_promoCode != null) _buildSummaryRow('Discount', -discount),
            const Divider(height: 24),
            _buildSummaryRow('Total', total, isTotal: true),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, double amount, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 20 : 16,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? Colors.black87 : Colors.black54,
            ),
          ),
          Text(
            amount < 0
                ? '-\$${(-amount).toStringAsFixed(2)}'
                : '\$${amount.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: isTotal ? 20 : 16,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? Colors.black87 : Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceOrderButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 2,
        ),
        onPressed: _isLoading ? null : () => _placeOrder(context),
        child: _isLoading
            ? const SizedBox(
          height: 24,
          width: 24,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        )
            : const Text(
          'Place Order',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}