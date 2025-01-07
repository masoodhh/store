import 'package:store/features/home/domain/entities/product_entity.dart';

class OrderEntity {
  final int id;
  final String title;
  final String image;
  final List<OrderStatus> orderStatuses;
  final List<ProductEntity> products;
  final double totalPrice;

  OrderEntity({
    required this.id,
    required this.title,
    required this.image,
    required this.orderStatuses,
    required this.products,
    required this.totalPrice,
  });
}

class OrderStatus {
  final String title;
  final DateTime? dateTime;
  final String description;
  final bool status;

  OrderStatus({
    required this.title,
     this.dateTime,
    required this.description,
    required this.status,
  });
}
