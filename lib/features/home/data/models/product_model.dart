import '../../domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  ProductModel(
      {required super.id,
      required super.image,
      required super.title,
      required super.description,
      required super.price,
      required super.count});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      image: json['avatar'],
      title: json['title'],
      description: json['description'],
      price: double.parse(json['price']),
      count: json['count']??0 ,
    );
  }factory ProductModel.fromJsonInOrders(Map<String, dynamic> json) {
    return ProductModel(
      id: json['product']['id'],
      image: json['product']['avatar'],
      title: json['product']['title'],
      description: json['product']['description'],
      price: double.parse(json['product']['price']),
      count: json['count']??0 ,
    );
  }
}
