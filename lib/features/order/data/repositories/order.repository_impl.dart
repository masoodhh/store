import 'package:store/core/resources/data_state.dart';

import '../../../../logger.dart';
import '../../domain/entities/order.entity.dart';
import '../../domain/repositories/order.repository.dart';
import '../models/order.model.dart';

class OrderRepositoryImpl implements OrderRepository {
  final dataProvider;

  OrderRepositoryImpl(this.dataProvider);

  @override
  Future<DataState<List<OrderEntity>>> getOrders() async {
    final DataState<List<OrderModel>> result = await dataProvider.getOrders();
    if (result is DataSuccess) {
      final List<OrderEntity> products = result.data! as List<OrderEntity>;
      return DataSuccess(products);
    } else {
      return result;
    }
  }

  @override
  Future<DataState<List<OrderEntity>>> getOrdersByStage(int categoryId) async {
    late final DataState<List<OrderModel>> result;
    if (categoryId == 0) {
      result = await dataProvider.getOrders();
    } else {
      result = await dataProvider.getOrdersByStage(categoryId);
    }
    if (result is DataSuccess) {
      final List<OrderEntity> products = result.data! as List<OrderEntity>;
      return DataSuccess(products);
    } else {
      return result;
    }
  }

  @override
  Future<DataState<bool>> addOrder(OrderModel orderModel) async {
    final DataState<bool> result = await dataProvider.addOrder(orderModel);
    if (result is DataSuccess) {
      return DataSuccess(true);
    } else {
      return result;
    }
  }
}
