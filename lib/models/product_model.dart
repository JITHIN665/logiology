import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

@freezed
class ProductResponse with _$ProductResponse {
  const factory ProductResponse({
    required List<Product> products,
    required int total,
    required int skip,
    required int limit,
  }) = _ProductResponse;

  factory ProductResponse.fromJson(Map<String, Object?> json) =>
      _$ProductResponseFromJson(json);
}

@freezed
class Product with _$Product {
  const factory Product({
    required int id,
    required String title,
    String? description,
    required String category,
    required double price,
    double? discountPercentage,
    double? rating,
    int? stock,
    @Default([]) List<String> tags, // Added default empty list
    String? brand,
    String? sku,
    int? weight,
    Dimensions? dimensions,
    String? warrantyInformation,
    String? shippingInformation,
    String? availabilityStatus,
    @Default([]) List<Review> reviews, // Changed name from Reviews to Review
    String? returnPolicy,
    int? minimumOrderQuantity,
    Meta? meta,
    required String thumbnail,
    @Default([]) List<String> images, // Added images field
  }) = _Product;

  factory Product.fromJson(Map<String, Object?> json) => _$ProductFromJson(json);
}

@freezed
class Dimensions with _$Dimensions {
  const factory Dimensions({
    required double width,
    required double height,
    required double depth,
  }) = _Dimensions;

  factory Dimensions.fromJson(Map<String, Object?> json) =>
      _$DimensionsFromJson(json);
}

@freezed
class Review with _$Review { // Changed name from Reviews to Review
  const factory Review({
    required int rating,
    String? comment,
    String? date,
    String? reviewerName,
    String? reviewerEmail,
  }) = _Review;

  factory Review.fromJson(Map<String, Object?> json) => _$ReviewFromJson(json);
}

@freezed
class Meta with _$Meta {
  const factory Meta({
    String? createdAt,
    String? updatedAt,
    String? barcode,
    String? qrCode,
  }) = _Meta;

  factory Meta.fromJson(Map<String, Object?> json) => _$MetaFromJson(json);
}