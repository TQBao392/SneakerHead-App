import 'package:get/get.dart';
import 'package:sneakerhead/data/repositories/brands/brand_repository.dart';
import 'package:sneakerhead/data/repositories/product/product_repository.dart';
import 'package:sneakerhead/features/shop/models/brand_model.dart';
import 'package:sneakerhead/features/shop/models/product_model.dart';
import 'package:sneakerhead/utils/popups/loaders.dart';

class BrandController extends GetxController {
  static BrandController get instance => Get.find();

  RxBool isLoading = true.obs;
  final RxList<BrandModel> allBrands = <BrandModel>[].obs;
  final RxList<BrandModel> featuredBrands = <BrandModel>[].obs;
  final brandRepository = Get.put(BrandRepository());

  @override
  void onInit() {
    getFeaturedBrands();
    super.onInit();
  }

  /// -- Load Brands
  Future<void> getFeaturedBrands() async {
    try {
      // Show loader while loading Brands
      isLoading.value = true;

      final brands = await brandRepository.getAllBrands();

      allBrands.assignAll(brands);

      featuredBrands.assignAll(
        allBrands.where((brand) => brand.isFeatured ?? false).take(4),
      );
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      // Stop loader
      isLoading.value = false;
    }
  }

  /// -- Get Brands For Category
  Future<List<BrandModel>> getBrandsForCategory(String categoryId) async {
    try {
      print('[BrandController] Fetching brands for category: $categoryId');

      final brands = await brandRepository.getBrandsForCategory(categoryId);

      print('[BrandController] Successfully fetched ${brands.length} brand(s) for category: $categoryId');
      return brands;
    } catch (e, stackTrace) {
      print('[BrandController] Error fetching brands for category: $categoryId');
      print('[BrandController] Error: $e');
      print('[BrandController] StackTrace: $stackTrace');

      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }


  /// Get BrandSpecific Products from your data source
  Future<List<ProductModel>> getBrandProducts({
    required String brandId,
    int limit = -1,
  }) async {
    try {
      print('[BrandController] Fetching products for brand: $brandId (limit: $limit)');

      final products = await ProductRepository.instance.getProductsForBrand(
        brandId: brandId,
        limit: limit,
      );

      print('[BrandController] Successfully fetched ${products.length} product(s) for brand: $brandId');
      return products;
    } catch (e, stackTrace) {
      print('[BrandController] Error fetching products for brand: $brandId');
      print('[BrandController] Error: $e');
      print('[BrandController] StackTrace: $stackTrace');

      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

}
