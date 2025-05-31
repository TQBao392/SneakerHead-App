import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:t_store/data/models/product_model.dart';

class ProductService {
  final CollectionReference _productsRef =
  FirebaseFirestore.instance.collection('products');

  Future<List<Product>> fetchProducts() async {
    final snapshot = await _productsRef.get();
    return snapshot.docs.map((doc) => Product.fromMap(doc.data() as Map<String, dynamic>, doc.id)).toList();
  }

  Future<void> addProduct(Product product) async {
    await _productsRef.add(product.toMap());
  }

  Future<void> deleteProduct(String id) async {
    await _productsRef.doc(id).delete();
  }

  Future<void> updateProduct(Product product) async {
    await _productsRef.doc(product.id).update(product.toMap());
  }
}
