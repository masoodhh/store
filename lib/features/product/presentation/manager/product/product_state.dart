part of 'product_cubit.dart';

class ProductState {
  final Status status;
  final List<ProductEntity>? similarProducts;
  final List<ReviewEntity>? reviews;

  ProductState({required this.status, required this.similarProducts, required this.reviews});

  factory ProductState.initial() {
    return ProductState(status: Status.INITIAL, similarProducts: [], reviews: null);
  }

  ProductState copyWith({
    Status? newStatus,
    List<ProductEntity>? newSimilarProducts,
    List<ReviewEntity>? newReview,
  }) {
    return ProductState(
      status: newStatus ?? status,
      similarProducts: newSimilarProducts ?? similarProducts,
      reviews: newReview ?? reviews,
    );
  }
}
