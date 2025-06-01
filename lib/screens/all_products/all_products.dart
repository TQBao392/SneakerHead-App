import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:t_store/screens/cart/cart_screen.dart';
import 'package:t_store/screens/product_detail_screen.dart';
import 'package:t_store/utils/constants/sizes.dart';

class AllProducts extends StatefulWidget {
  const AllProducts({super.key});

  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  final List<CartItem> _cartItems = [];
  List<String> brands = ['All Brands'];
  String _selectedBrand = 'All Brands';
  String _sortOption = 'Price: Low to High';
  final int _limit = 20;
  DocumentSnapshot? _lastDocument;
  bool _isLoadingMore = false;
  bool _hasMore = true;
  final List<Map<String, dynamic>> _products = [];

  void _addToCart(Map<String, dynamic> product) {
    final title = product['name'] ?? 'Unknown';
    final existingIndex = _cartItems.indexWhere((item) => item.title == title);

    setState(() {
      if (existingIndex >= 0) {
        _cartItems[existingIndex].quantity++;
      } else {
        _cartItems.add(CartItem(
          brand: product['brand'] ?? 'No Brand',
          title: title,
          imageUrl: product['imageUrl'] ?? '',
          price: (product['price'] as num?)?.toDouble() ?? 0.0,
          quantity: 1,
        ));
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$title added to cart')),
    );
  }

  void _extractBrands(List<Map<String, dynamic>> products) {
    final uniqueBrands = products.map((p) => p['brand'] as String?).whereType<String>().toSet();
    setState(() {
      brands = ['All Brands', ...uniqueBrands.toList()..sort()];
    });
  }

  List<Map<String, dynamic>> _filterAndSortProducts(List<Map<String, dynamic>> products) {
    List<Map<String, dynamic>> filtered = _selectedBrand == 'All Brands'
        ? products
        : products.where((p) => p['brand'] == _selectedBrand).toList();

    switch (_sortOption) {
      case 'Price: Low to High':
        filtered.sort((a, b) => ((a['price'] as num?) ?? 0).compareTo((b['price'] as num?) ?? 0));
        break;
      case 'Price: High to Low':
        filtered.sort((a, b) => ((b['price'] as num?) ?? 0).compareTo((a['price'] as num?) ?? 0));
        break;
      case 'Name: A-Z':
        filtered.sort((a, b) => (a['name'] ?? '').toString().compareTo((b['name'] ?? '').toString()));
        break;
      case 'Name: Z-A':
        filtered.sort((a, b) => (b['name'] ?? '').toString().compareTo((a['name'] ?? '').toString()));
        break;
    }

    return filtered;
  }

  Future<void> _loadMoreProducts() async {
    if (_isLoadingMore || !_hasMore) return;

    setState(() {
      _isLoadingMore = true;
    });

    Query query = FirebaseFirestore.instance
        .collection('products')
        .orderBy('name')
        .limit(_limit);
    if (_lastDocument != null) {
      query = query.startAfterDocument(_lastDocument!);
    }

    try {
      final snapshot = await query.get();
      final newProducts = snapshot.docs
          .map((doc) => {...doc.data() as Map<String, dynamic>, 'id': doc.id})
          .toList();

      final existingIds = _products.map((p) => p['id'] as String?).toSet();
      final uniqueNewProducts = newProducts.where((p) => !existingIds.contains(p['id'])).toList();

      setState(() {
        _products.addAll(uniqueNewProducts);
        _lastDocument = snapshot.docs.isNotEmpty ? snapshot.docs.last : null;
        _hasMore = newProducts.length == _limit;
        _isLoadingMore = false;
        if (brands.length == 1 && uniqueNewProducts.isNotEmpty) {
          _extractBrands(_products);
        }
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading products: $e')),
      );
      setState(() {
        _isLoadingMore = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadMoreProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Products'),
        leading: null, // Remove the back button
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartScreen(cartItems: _cartItems),
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace / 2),
          child: _products.isEmpty && _isLoadingMore
              ? const Center(child: CircularProgressIndicator())
              : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 60,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Row(
                        children: [
                          const Text('Filter by brand:'),
                          const SizedBox(width: 8),
                          DropdownButton<String>(
                            value: _selectedBrand,
                            items: brands
                                .map((brand) => DropdownMenuItem(
                              value: brand,
                              child: Text(brand),
                            ))
                                .toList(),
                            onChanged: (value) {
                              if (value != null) {
                                setState(() {
                                  _selectedBrand = value;
                                });
                              }
                            },
                          ),
                        ],
                      ),
                      const SizedBox(width: 30),
                      Row(
                        children: [
                          const Text('Sort by:'),
                          const SizedBox(width: 8),
                          DropdownButton<String>(
                            value: _sortOption,
                            items: [
                              'Price: Low to High',
                              'Price: High to Low',
                              'Name: A-Z',
                              'Name: Z-A',
                            ]
                                .map((option) => DropdownMenuItem(
                              value: option,
                              child: Text(option),
                            ))
                                .toList(),
                            onChanged: (value) {
                              if (value != null) {
                                setState(() {
                                  _sortOption = value;
                                });
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification scrollInfo) {
                    if (!_isLoadingMore &&
                        _hasMore &&
                        scrollInfo.metrics.pixels >=
                            scrollInfo.metrics.maxScrollExtent * 0.8) {
                      _loadMoreProducts();
                    }
                    return false;
                  },
                  child: GridView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: _filterAndSortProducts(_products).length +
                        (_isLoadingMore ? 1 : 0),
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: TSizes.gridViewSpacing,
                      crossAxisSpacing: TSizes.gridViewSpacing,
                      childAspectRatio: 0.75,
                    ),
                    itemBuilder: (context, index) {
                      if (index ==
                          _filterAndSortProducts(_products).length) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      final product = _filterAndSortProducts(_products)[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailScreen(
                                product: product,
                                cartItems: _cartItems,
                              ),
                            ),
                          );
                        },
                        child: TProductCardVertical(
                          imageUrl: product['imageUrl'] ?? '',
                          title: product['name'] ?? 'No name',
                          brand: product['brand'] ?? 'No brand',
                          price: (product['price'] as num?)?.toDouble() ?? 0.0,
                          onAddToCart: () => _addToCart(product),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}