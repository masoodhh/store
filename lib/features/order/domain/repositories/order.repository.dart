
import '../../../../core/resources/data_state.dart';
import '../entities/order.entity.dart';

abstract class OrderRepository {
  Future<DataState<List<OrderEntity>>> getOrders();

  Future<DataState<List<OrderEntity>>> getOrdersByStage(int categoryId);
  Future<DataState<bool>> addOrder(OrderEntity orderEntity);
}
