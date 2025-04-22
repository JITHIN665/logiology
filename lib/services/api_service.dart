import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logiology/models/product_model.dart';
import 'package:logiology/utils/constants.dart';

class ApiService {
  Future<List<Product>> fetchAllProducts() async {
    final List<Product> allProducts = [];
    int skip = 0;
    const int limit = 30;
    bool hasMore = true;

    try {
      while (hasMore) {
        final response = await http.get(
          Uri.parse('${AppConstants.productsEndpoint}?skip=$skip&limit=$limit'),
        );

        if (response.statusCode == 200) {
          final jsonData = json.decode(response.body);
          final productResponse = ProductResponse.fromJson(jsonData);
          
          allProducts.addAll(productResponse.products);
          
          // Check if we've fetched all products
          if (productResponse.products.length < limit || 
              allProducts.length >= productResponse.total) {
            hasMore = false;
          } else {
            skip += limit;
          }
        } else {
          throw Exception('Failed to load products at skip=$skip');
        }
      }
      return allProducts;
    } catch (e) {
      throw Exception('Failed to load all products: $e');
    }
  }

  Future<Product> fetchProductDetails(int productId) async {
    final response = await http.get(
      Uri.parse('${AppConstants.productsEndpoint}/$productId'),
    );

    if (response.statusCode == 200) {
      return Product.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load product details');
    }
  }
}