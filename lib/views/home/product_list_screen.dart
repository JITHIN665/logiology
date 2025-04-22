import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logiology/controllers/product_controller.dart';
import 'package:logiology/controllers/profile_controller.dart';
import 'package:logiology/utils/routes.dart';
import 'package:logiology/views/widgets/custom_search_bar.dart';
import 'package:logiology/views/widgets/filter_bottom_sheet.dart';
import 'package:logiology/views/home/widgets/product_card.dart';

class ProductListScreen extends StatelessWidget {
  final ProductController _controller = Get.find();
  final ProfileController _profileController = Get.find();

  ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          IconButton(icon: const Icon(Icons.filter_list), onPressed: () => Get.bottomSheet(FilterBottomSheet())),
          SizedBox(width: 16),
          Obx(() {
            return GestureDetector(
              onTap: () => Get.toNamed(Routes.profile),
              child: CircleAvatar(
                radius: 15,
                backgroundImage:
                    _profileController.profileImagePath.isNotEmpty
                        ? FileImage(File(_profileController.profileImagePath.value))
                        : const AssetImage('assets/default_profile.png') as ImageProvider,
              ),
            );
          }),
          SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomSearchBar(
              onChanged: (query) {
                _controller.searchQuery.value = query;
                _controller.applyFilters();
              },
            ),
          ),
          Expanded(
            child: Obx(() {
              if (_controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              return _controller.filteredProducts.isEmpty
                  ? const Center(child: Text('No products found'))
                  : GridView.builder(
                    padding: const EdgeInsets.all(8),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: _controller.filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = _controller.filteredProducts[index];
                      return ProductCard(product: product, onTap: () => Get.toNamed(Routes.productDetail, arguments: product));
                    },
                  );
            }),
          ),
        ],
      ),
    );
  }
}
