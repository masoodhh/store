import 'package:store/features/home/domain/entities/product_entity.dart';

class OrderEntity {
  final int? id;
  final String title;
  final String image;
  final List<OrderStages> orderStages;
  final List<ProductEntity> products;
  final double totalPrice;

  OrderEntity({
    required this.id,
    required this.title,
    required this.image,
    required this.orderStages,
    required this.products,
    required this.totalPrice,
  });


}

class OrderStages {
  final String title;
  final DateTime? dateTime;
  final String description;
  final bool status;

  OrderStages({
    required this.title,
    this.dateTime,
    required this.description,
    required this.status,
  });
}
