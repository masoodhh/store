
import '../../../../core/resources/data_state.dart';
import '../../../../core/use_case/use_case.dart';
import '../entities/order.entity.dart';
import '../repositories/order.repository.dart';

class GetOrdersByStageUsecase extends UseCase<DataState<List<OrderEntity>>,int> {
  final OrderRepository orderRepository;

  GetOrdersByStageUsecase(this.orderRepository);

  @override
  Future<DataState<List<OrderEntity>>> call(int categoryId) {
    return orderRepository.getOrdersByStage(categoryId);

  }

}