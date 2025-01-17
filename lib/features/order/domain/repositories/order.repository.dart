
import '../../../../core/resources/data_state.dart';
import '../../data/models/order.model.dart';
import '../entities/order.entity.dart';

abstract class OrderRepository {
  Future<DataState<List<OrderEntity>>> getOrders();

  Future<DataState<List<OrderEntity>>> getOrdersByStage(int categoryId);
  Future<DataState<bool>> addOrder(OrderModel orderModel);
}
