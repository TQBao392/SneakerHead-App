import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sneakerhead/features/shop/models/brand_model.dart';
import 'package:sneakerhead/utils/exceptions/firebase_exceptions.dart';
import 'package:sneakerhead/utils/exceptions/format_exceptions.dart';
import 'package:sneakerhead/utils/exceptions/platform_exceptions.dart';

class BrandRepository extends GetxController {
  static BrandRepository get instance => Get.find();

  /// Variables
  final _db = FirebaseFirestore.instance;

  /// Get all categories
  Future<List<BrandModel>> getAllBrands() async {
    try {
      final snapshot = await _db.collection('Brands').get();
      final result =
          snapshot.docs.map((e) => BrandModel.fromSnapshot(e)).toList();
      return result;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong while fetching Banners.';
    }
  }

  /// Get Brands for Category
  Future<List<BrandModel>> getBrandsForCategory(String categoryId) async {
    try {
      print('[BrandRepository] Fetching brand-category links for categoryId: $categoryId');

      final brandCategoryQuery = await _db
          .collection('BrandCategory')
          .where('categoryId', isEqualTo: categoryId)
          .get();

      final rawBrandIds = brandCategoryQuery.docs
          .map((doc) => doc['brandId'] as String? ?? '')
          .toList();

      print('[BrandRepository] Raw brand IDs: $rawBrandIds');

      final validBrandIds = rawBrandIds
          .where((id) => id.trim().isNotEmpty)
          .toList();

      print('[BrandRepository] Valid brand IDs: $validBrandIds');

      if (validBrandIds.isEmpty) {
        print('[BrandRepository] No valid brand IDs found for category: $categoryId');
        return [];
      }

      final brandsQuery = await _db
          .collection('Brands')
          .where(FieldPath.documentId, whereIn: validBrandIds)
          .limit(2)
          .get();

      final brands = brandsQuery.docs
          .map((doc) => BrandModel.fromSnapshot(doc))
          .toList();

      print('[BrandRepository] Successfully fetched ${brands.length} brand(s) for category: $categoryId');

      return brands;
    } on FirebaseException catch (e) {
      print('[BrandRepository] FirebaseException: ${e.message}');
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      print('[BrandRepository] FormatException: Malformed data');
      throw const TFormatException();
    } on PlatformException catch (e) {
      print('[BrandRepository] PlatformException: ${e.code}');
      throw TPlatformException(e.code).message;
    } catch (e) {
      print('[BrandRepository] Unknown error: $e');
      throw 'Something went wrong while fetching brands.';
    }

    // ✅ Fallback safeguard — this ensures non-null return
    return [];
  }

}
