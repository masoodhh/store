import '../../domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  ProductModel(
      {required super.id,
      required super.image,
      required super.title,
      required super.description,
      required super.price,required super.count});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      image: json['image'],
      title: json['title'],
      description: json['description'],
      price: json['price'].toDouble(),
      count: json['count']?.toInt()??0,
    );
  }
}
