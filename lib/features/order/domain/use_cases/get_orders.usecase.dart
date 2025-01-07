
import '../../../../core/resources/data_state.dart';
import '../../../../core/use_case/use_case.dart';
import '../entities/order.entity.dart';
import '../repositories/order.repository.dart';

class GetOrdersUsecase extends NoParamUseCase<DataState<List<OrderEntity>>> {
  final OrderRepository orderRepository;

  GetOrdersUsecase(this.orderRepository);

  @override
  Future<DataState<List<OrderEntity>>> call() {
    return orderRepository.getOrders();
  }
}