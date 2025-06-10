import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sneakerhead/features/shop/models/brand_model.dart';
import 'package:sneakerhead/features/shop/models/product_attribute_model.dart';
import 'package:sneakerhead/features/shop/models/product_variation_model.dart';
import 'package:sneakerhead/utils/constants/enums.dart';

class ProductModel {
  String id;
  int stock;
  String? sku;
  double price;
  String title;
  DateTime? date;
  double salePrice;
  String thumbnail;
  bool? isFeatured;
  BrandModel? brand;
  String? description;
  String? categoryId;
  List<String>? images;
  String productType;
  List<ProductAttributeModel>? productAttributes;
  List<ProductVariationModel>? productVariations;

  ProductModel({
    required this.id,
    required this.title,
    required this.stock,
    required this.price,
    required this.thumbnail,
    required this.productType,
    this.sku,
    this.brand,
    this.date,
    this.images,
    this.salePrice = 0.0,
    this.isFeatured,
    this.categoryId,
    this.description,
    this.productAttributes,
    this.productVariations,
  });

  static ProductModel empty() => ProductModel(
    id: '',
    title: '',
    stock: 0,
    price: 0,
    thumbnail: '',
    productType: '',
  );

  Map<String, dynamic> toJson() {
    return {
      'SKU': sku,
      'Title': title,
      'Stock': stock,
      'Price': price,
      'Images': images ?? [],
      'Thumbnail': thumbnail,
      'SalePrice': salePrice,
      'IsFeatured': isFeatured,
      'CategoryId': categoryId,
      'Brand': brand?.toJson(),
      'Description': description,
      'ProductType': productType,
      'ProductAttributes': productAttributes?.map((e) => e.toJson()).toList() ?? [],
      'ProductVariations': productVariations?.map((e) => e.toJson()).toList() ?? [],
    };
  }

  factory ProductModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;
    return ProductModel(
      id: snapshot.id,
      title: data['Title']?.toString() ?? '',
      price: double.tryParse(data['Price'].toString()) ?? 0.0,
      salePrice: double.tryParse(data['SalePrice'].toString()) ?? 0.0,
      thumbnail: data['Thumbnail'] != null
          ? data['Thumbnail'].toString()
          : 'https://picsum.photos/250?image=9',
      description: data['Description']?.toString() ?? '',
      sku: data['SKU']?.toString() ?? '',
      brand: data['Brand'] != null ? BrandModel.fromJson(data['Brand']) : null,
      categoryId: data['CategoryId']?.toString() ?? '',
      productType: data['ProductType']?.toString() ?? ProductType.single.name,
      stock: int.tryParse(data['Stock'].toString()) ?? 0,
      images: data['Images'] != null ? List<String>.from(data['Images']) : [],
      productAttributes: data['ProductAttributes'] != null
          ? List<Map<String, dynamic>>.from(data['ProductAttributes'])
          .map((e) => ProductAttributeModel.fromJson(e))
          .toList()
          : [],
      productVariations: data['ProductVariations'] != null
          ? List<Map<String, dynamic>>.from(data['ProductVariations'])
          .map((e) => ProductVariationModel.fromJson(e))
          .toList()
          : [],
    );
  }



  factory ProductModel.fromQuerySnapshot(QueryDocumentSnapshot<Object?> document) {
    final data = document.data() as Map<String, dynamic>;
    return ProductModel(
      id: document.id,
      sku: data['SKU']?.toString(),
      title: data['Title']?.toString() ?? '',
      stock: int.tryParse(data['Stock'].toString()) ?? 0,
      isFeatured: data['IsFeatured'] ?? false,
      price: double.tryParse(data['Price']?.toString() ?? '0') ?? 0,
      salePrice: double.tryParse(data['SalePrice']?.toString() ?? '0') ?? 0,
      thumbnail: data['Thumbnail'] != null
          ? data['Thumbnail'].toString()
          : (data['Images'] != null && data['Images'].isNotEmpty
          ? data['Images'][0].toString()
          : ''),
      categoryId: data['CategoryId']?.toString() ?? '',
      description: data['Description']?.toString() ?? '',
      productType: data['ProductType']?.toString() ?? '',
      brand: data['Brand'] != null ? BrandModel.fromJson(data['Brand']) : null,
      images: data['Images'] != null ? List<String>.from(data['Images']) : [],
      productAttributes: data['ProductAttributes'] != null
          ? (data['ProductAttributes'] as List<dynamic>)
          .map((e) => ProductAttributeModel.fromJson(e))
          .toList()
          : [],
      productVariations: data['ProductVariations'] != null
          ? (data['ProductVariations'] as List<dynamic>)
          .map((e) => ProductVariationModel.fromJson(e))
          .toList()
          : [],
    );
  }
}
