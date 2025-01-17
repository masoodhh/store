import '../../../../core/resources/data_state.dart';
import '../../../../core/use_case/use_case.dart';
import '../entities/order.entity.dart';
import '../repositories/order.repository.dart';

class AddOrderUsecase extends UseCase<DataState<bool>, OrderEntity> {
  final OrderRepository orderRepository;

  AddOrderUsecase(this.orderRepository);

  @override
  Future<DataState<bool>> call(OrderEntity orderEntity) {
    return orderRepository.addOrder(orderEntity);
  }
}
