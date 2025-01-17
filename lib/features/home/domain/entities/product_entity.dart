import 'cart_entity.dart';

class ProductEntity {
  final int id;
  final String image;
  final String title;
  final String description;
  final double price;
  int count;

  ProductEntity(
      {required this.id,
      required this.image,
      required this.title,
      required this.description,
      required this.price,
      required this.count});

  ProductEntity copyWith({
    double? price,
    int? count,
  }) {
    return ProductEntity(
      id: id,
      image: image,
      title: title,
      description: description,
      price: price ?? this.price,
      count: count ?? this.count,
    );
  }
}
