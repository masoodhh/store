import 'package:store/features/home/domain/entities/product_entity.dart';
import 'package:store/features/product/domin/entities/review_entity.dart';

class ProductDetailesEntity {
  // final ProductEntity product;
  final List<ProductEntity>? similarProducts;
  final List<ReviewEntity>? reviews;

  ProductDetailesEntity({
    // required this.product,
    this.similarProducts,
    this.reviews,
  });
}
