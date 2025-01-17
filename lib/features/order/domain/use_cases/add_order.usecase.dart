import '../../../../core/resources/data_state.dart';
import '../../../../core/use_case/use_case.dart';
import '../../data/models/order.model.dart';
import '../repositories/order.repository.dart';

class AddOrderUsecase extends UseCase<DataState<bool>, OrderModel> {
  final OrderRepository orderRepository;

  AddOrderUsecase(this.orderRepository);

  @override
  Future<DataState<bool>> call(OrderModel orderEntity) {
    return orderRepository.addOrder(orderEntity);
  }
}
