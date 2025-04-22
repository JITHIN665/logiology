import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logiology/controllers/product_controller.dart';
import 'package:logiology/views/widgets/custom_button.dart';
import 'package:logiology/views/widgets/custom_textfield.dart';
import 'package:logiology/views/widgets/multi_select_dropdown.dart';

class FilterBottomSheet extends StatelessWidget {
  final ProductController _controller = Get.find();

  FilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.8),
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(borderRadius: BorderRadius.vertical(top: Radius.circular(20)), color: Colors.white),
      child: Obx(() {
        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Filter Products', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              const Text('Categories', style: TextStyle(fontWeight: FontWeight.bold)),
              MultiSelectDropdown(
                items: _controller.categories,
                selectedItems: _controller.selectedCategories,
                onSelectionChanged: (selected) {
                  _controller.applyFilters();
                },
              ),
              const SizedBox(height: 16),
              const Text('Tags', style: TextStyle(fontWeight: FontWeight.bold)),
              MultiSelectDropdown(
                items: _controller.tags,
                selectedItems: _controller.selectedTags,
                onSelectionChanged: (selected) {
                  _controller.applyFilters();
                },
              ),
              const SizedBox(height: 16),
              const Text('Price Range', style: TextStyle(fontWeight: FontWeight.bold)),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      labelText: 'Min Price',
                      keyboardType: TextInputType.number,
                      initialValue: _controller.minPrice.value.toStringAsFixed(2),
                      onChanged: (value) {
                        final newValue = double.tryParse(value) ?? 0;
                        _controller.minPrice.value = newValue;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CustomTextField(
                      labelText: 'Max Price',
                      keyboardType: TextInputType.number,
                      initialValue: _controller.maxPrice.value.toStringAsFixed(2),
                      onChanged: (value) {
                        final newValue = double.tryParse(value) ?? 1000;
                        _controller.maxPrice.value = newValue;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    _controller.applyFilters();
                  },
                  child: const Text('Apply Price Filter'),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      onPressed: () {
                        _controller.resetFilters();
                        Get.back();
                      },
                      backgroundColor: Colors.grey,
                      child: const Text('Reset'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CustomButton(
                      onPressed: () {
                        _controller.applyFilters();
                        Get.back();
                      },
                      child: const Text('Apply'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
