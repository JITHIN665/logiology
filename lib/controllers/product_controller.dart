import 'package:get/get.dart';
import 'package:logiology/models/product_model.dart';
import 'package:logiology/services/api_service.dart';

class ProductController extends GetxController {
  final ApiService _apiService = Get.find();

  final RxList<Product> allProducts = <Product>[].obs;
  final RxList<Product> displayedProducts = <Product>[].obs;

  final RxList<String> availableCategories = <String>[].obs;
  final RxList<String> availableTags = <String>[].obs;

  final RxList<String> selectedCategories = <String>[].obs;
  final RxList<String> selectedTags = <String>[].obs;

  final RxDouble minSelectedPrice = 0.0.obs;
  final RxDouble maxSelectedPrice = 1000.0.obs;

  final RxString searchKeyword = ''.obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    loadProducts();
    super.onInit();
  }

  ///
  ///Load Products
  ///
  Future<void> loadProducts() async {
    try {
      isLoading.value = true;

      final products = await _apiService.fetchAllProducts();
      allProducts.assignAll(products);
      displayedProducts.assignAll(products);

      availableCategories.assignAll(products.map((p) => p.category).toSet().toList());
      availableTags.assignAll(products.expand((p) => p.tags).toSet().toList());

      if (products.isNotEmpty) {
        final prices = products.map((product) => product.price);
        minSelectedPrice.value = prices.reduce((min, price) => price < min ? price : min);
        maxSelectedPrice.value = prices.reduce((max, price) => price > max ? price : max);
      }
    } catch (error) {
      Get.snackbar("Error", "Unable to fetch products: ${error.toString()}");
    } finally {
      isLoading.value = false;
    }
  }

  ///
  ///apply filter
  ///
  void applyProductFilters() {
    if (maxSelectedPrice.value < minSelectedPrice.value) {
      final tempPrice = maxSelectedPrice.value;
      maxSelectedPrice.value = minSelectedPrice.value;
      minSelectedPrice.value = tempPrice;
    }

    displayedProducts.assignAll(
      allProducts.where((product) {
        final matchesSearch = searchKeyword.isEmpty ||
            product.title.toLowerCase().contains(searchKeyword.toLowerCase());

        final matchesCategory = selectedCategories.isEmpty ||
            selectedCategories.contains(product.category);

        final matchesTags = selectedTags.isEmpty ||
            product.tags.any((tag) => selectedTags.contains(tag));

        final matchesPriceRange = product.price >= minSelectedPrice.value &&
            product.price <= maxSelectedPrice.value;

        return matchesSearch && matchesCategory && matchesTags && matchesPriceRange;
      }),
    );
  }


  ///
  ///clear applied filter 
  ///
  void clearAllFilters() {
    searchKeyword.value = '';
    selectedCategories.clear();
    selectedTags.clear();

    if (allProducts.isNotEmpty) {
      final prices = allProducts.map((product) => product.price);
      minSelectedPrice.value = prices.reduce((min, price) => price < min ? price : min);
      maxSelectedPrice.value = prices.reduce((max, price) => price > max ? price : max);
    }

    displayedProducts.assignAll(allProducts);
  }
}