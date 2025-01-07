import 'package:store/core/resources/data_state.dart';
import 'package:store/features/order/data/data_sources/data_provider.dart';

import '../../../../logger.dart';
import '../../domain/entities/order.entity.dart';
import '../../domain/repositories/order.repository.dart';
import '../models/order.model.dart';

class OrderRepositoryImpl implements OrderRepository {
  @override
  Future<DataState<List<OrderEntity>>> getOrders() async {
    try {
      final result = await DataProvider().getOrders();
      List<OrderEntity> orders =
          List<OrderEntity>.from(result.map((order) => OrderModel.fromJson(order)).toList());
      return DataSuccess(orders);
    } catch (error) {
      return DataFailed("error is $error");
    }
  }

  @override
  Future<DataState<List<OrderEntity>>> getOrdersByCategory(int categoryId) async {
    final result = await DataProvider().getOrdersByCategory(categoryId);
    List<OrderEntity> orders =
        List<OrderEntity>.from(result.map((order) => OrderModel.fromJson(order)).toList());
    return DataSuccess(orders);
  }
}
