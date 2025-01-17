import 'package:store/features/home/data/models/product_model.dart';

import '../../../../logger.dart';
import '../../domain/entities/order.entity.dart';

class OrderModel extends OrderEntity {
  OrderModel({
    required super.id,
    required super.title,
    // required super.image,
    required super.orderStages,
    required super.products,
    // required super.totalPrice,
  }) : super(
          image: products[0].image, // یا هر مقدار پیش‌فرض دیگر
          totalPrice: products
              .map((product) => product.price * product.count)
              .reduce((a, b) => a + b), // محاسبه قیمت کل
        );

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    final products = (json['products'] as List<dynamic>)
        .map((jsonData) => ProductModel.fromJsonInOrders(jsonData as Map<String, dynamic>))
        .toList();
    return OrderModel(
      id: json['id'] as int,
      title: json['title'] as String,
      // image: json['products'][0]['product']['avatar'] as String,
      products: products,
      orderStages: (json['stages'] as List<dynamic>)
          .map((jsonData) => OrderStagesModel.fromJson(jsonData as Map<String, dynamic>))
          .toList(),
      // totalPrice: products.map((product) => product.price * product.count).reduce((a, b) => a + b),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'user_id': 1,
      'products_w': products.map((e) => {"id": e.id, "count": e.count}).toList(),
    };
  }
}

class OrderStagesModel extends OrderStages {
  OrderStagesModel({
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

  factory OrderStagesModel.fromJson(Map<String, dynamic> json) {
    return OrderStagesModel(
      title: json['title'] as String,
      dateTime: json['date'] != null ? DateTime.parse(json['date'] as String) : null,
      description: json['description'] as String,
      status: json['date'] != null,
    );
  }
}
