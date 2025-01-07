import 'cart_entity.dart';

class ProductEntity extends CartEntity {
  ProductEntity(
      {required super.id,
      required super.image,
      required super.title,
      required super.description,
      required super.price,
      required super.count});
}
