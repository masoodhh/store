import 'package:store/features/home_page/domain/entities/cart_entity.dart';

class ProductEntity extends CartEntity {
  ProductEntity(
      {required super.id,
      required super.image,
      required super.title,
      required super.description,
      required super.price});
}
