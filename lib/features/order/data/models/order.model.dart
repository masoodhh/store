import 'package:store/features/home/data/models/product_model.dart';

import '../../../../logger.dart';
import '../../domain/entities/order.entity.dart';

class OrderModel extends OrderEntity {
  OrderModel({
    required super.id,
    required super.title,
    required super.image,
    required super.orderStatuses,
    required super.products,
    required super.totalPrice,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    final products = (json['products'] as List<dynamic>)
        .map((jsonData) => ProductModel.fromJson(jsonData as Map<String, dynamic>))
        .toList();
    return OrderModel(
      id: json['id'] as int,
      title: json['title'] as String,
      image: json['image'] as String,
      products: products,
      orderStatuses: (json['orderStatuses'] as List<dynamic>)
          .map((jsonData) => OrderStatusModel.fromJson(jsonData as Map<String, dynamic>))
          .toList(),
      totalPrice: products.map((product) => product.price * product.count).reduce((a, b) => a + b),
    );
  }
}

class OrderStatusModel extends OrderStatus {
  OrderStatusModel({
    required String title,
    DateTime? dateTime,
    required String description,
    required bool status,
  }) : super(
          title: title,
          dateTime: dateTime,
          description: description,
          status: status,
        );

  factory OrderStatusModel.fromJson(Map<String, dynamic> json) {
    return OrderStatusModel(
      title: json['title'] as String,
      dateTime: json['dateTime'] != "" ? DateTime.parse(json['dateTime'] as String) : null,
      description: json['description'] as String,
      status: json['status'] as bool,
    );
  }
}
