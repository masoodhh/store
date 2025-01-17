import 'package:store/features/home/data/models/product_model.dart';
import 'package:store/features/product/data/models/review_model.dart';
import 'package:store/features/product/domin/entities/product_detail_entity.dart';

import '../../../home/domain/entities/product_entity.dart';
import '../../domin/entities/review_entity.dart';

class ProductDetailesModel extends ProductDetailesEntity {
  final List<ProductModel> similarProducts;
  final List<ReviewModel> reviews;

  ProductDetailesModel({required this.similarProducts, required this.reviews})
      : super(
          reviews: reviews.cast<ReviewEntity>(),
          similarProducts: similarProducts.cast<ProductEntity>(),
        );

  factory ProductDetailesModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailesModel(
      similarProducts: (json['similar_products'] as List).map((item) => ProductModel.fromJson(item)).toList(),
      reviews: (json['reviews'] as List).map((item) => ReviewModel.fromJson(item)).toList(),
    );
  }
}
