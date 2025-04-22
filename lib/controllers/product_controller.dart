import 'package:get/get.dart';
import 'package:logiology/models/product_model.dart';
import 'package:logiology/services/api_service.dart';

class ProductController extends GetxController {
  final ApiService _apiService = Get.find();

  final RxList<Product> products = <Product>[].obs;
  final RxList<Product> filteredProducts = <Product>[].obs;
  final RxList<String> categories = <String>[].obs;
  final RxList<String> tags = <String>[].obs;
  final RxList<String> selectedCategories = <String>[].obs;
  final RxList<String> selectedTags = <String>[].obs;
  final RxDouble minPrice = 0.0.obs;
  final RxDouble maxPrice = 1000.0.obs;
  late final RxString searchQuery = ''.obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    fetchAllProducts();
    super.onInit();
  }

  Future<void> fetchAllProducts() async {
    try {
      isLoading.value = true;
      final allProducts = await _apiService.fetchAllProducts();

      products.assignAll(allProducts);
      filteredProducts.assignAll(allProducts);

      // Extract unique categories and tags
      categories.assignAll(allProducts.map((p) => p.category).toSet().toList());

      tags.assignAll(allProducts.expand((p) => p.tags).toSet().toList());

      // Set initial price range
      if (allProducts.isNotEmpty) {
        final prices = allProducts.map((p) => p.price).toList();
        minPrice.value = prices.reduce((a, b) => a < b ? a : b);
        maxPrice.value = prices.reduce((a, b) => a > b ? a : b);
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to load products: ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }

  void applyFilters() {
    // Ensure max price is not less than min price
    if (maxPrice.value < minPrice.value) {
      final temp = maxPrice.value;
      maxPrice.value = minPrice.value;
      minPrice.value = temp;
    }

    filteredProducts.assignAll(
      products.where((product) {
        // Search filter
        bool matchesSearch = searchQuery.isEmpty || product.title.toLowerCase().contains(searchQuery.toLowerCase());

        // Category filter
        bool matchesCategory = selectedCategories.isEmpty || selectedCategories.contains(product.category);

        // Tag filter
        bool matchesTag = selectedTags.isEmpty || product.tags.any((tag) => selectedTags.contains(tag));

        // Price filter
        bool matchesPrice = product.price >= minPrice.value && product.price <= maxPrice.value;

        return matchesSearch && matchesCategory && matchesTag && matchesPrice;
      }),
    );
  }

  void resetFilters() {
    searchQuery.value = '';
    selectedCategories.clear();
    selectedTags.clear();
    if (products.isNotEmpty) {
      final prices = products.map((p) => p.price).toList();
      minPrice.value = prices.reduce((a, b) => a < b ? a : b);
      maxPrice.value = prices.reduce((a, b) => a > b ? a : b);
    }
    filteredProducts.assignAll(products);
  }
}
