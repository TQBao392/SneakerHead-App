class Product {
  final String id;
  final String name;
  final String brand;
  final double price;
  final String imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.brand,
    required this.price,
    required this.imageUrl,
  });

  factory Product.fromMap(Map<String, dynamic> data, String documentId) {
    return Product(
      id: documentId,
      name: data['name'],
      brand: data['brand'],
      price: (data['price'] as num).toDouble(),
      imageUrl: data['imageUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'brand': brand,
      'price': price,
      'imageUrl': imageUrl,
    };
  }
}
