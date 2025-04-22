import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logiology/models/product_model.dart';
import 'package:logiology/views/widgets/custom_button.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Product product = Get.arguments;

    return Scaffold(
      appBar: AppBar(title: const Text('Product Details')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 300,
              decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(12)),
              child: Center(
                child: Image.network(
                  product.thumbnail,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                ),
              ),
            ),

            const SizedBox(height: 20),
            Text(product.title, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.blue, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10),
                Chip(label: Text(product.category), backgroundColor: Colors.blue.withOpacity(0.1)),
              ],
            ),

            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 20),
                Text(' ${product.rating?.toStringAsFixed(1) ?? 'N/A'}', style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(width: 20),
                Text('${product.stock ?? 0} in stock', style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
            const SizedBox(height: 20),
            Text('Description', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(product.description ?? 'No description available', style: Theme.of(context).textTheme.bodyMedium),
            if (product.discountPercentage != null && product.discountPercentage! > 0)
              Column(
                children: [
                  const SizedBox(height: 20),
                  Text(
                    '${product.discountPercentage?.toStringAsFixed(1)}% discount',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.green, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            const SizedBox(height: 20),
            Text('Reviews', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Column(
              spacing: 5,
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
                  product.reviews
                      .map(
                        (review) => Container(
                          padding: EdgeInsets.all(6),
                          width: double.infinity,
                          decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${review.reviewerName} ${List.generate(review.rating, (index) => "⭐️").join()}",
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                              SizedBox(height: 4),
                              // Text(convertToMonthDayYear(dateTimeString: review.date) ?? "", style: TextStyle(fontSize: 12)),
                              SizedBox(height: 4),
                              Text(review.comment ?? "", style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.w500)),
                              SizedBox(height: 10),
                            ],
                          ),
                        ),
                      )
                      .toList(),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: CustomButton(
                onPressed: () {
                  Get.snackbar('Added to Cart', '${product.title} has been added to your cart', snackPosition: SnackPosition.BOTTOM);
                },
                child: const Text('Add to Cart', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
