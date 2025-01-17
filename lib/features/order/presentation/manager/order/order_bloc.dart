import 'package:bloc/bloc.dart';
import 'package:store/core/resources/data_state.dart';
import 'package:store/features/order/domain/use_cases/get_orders.usecase.dart';

import '../../../../../core/params/params.dart';
import '../../../../../logger.dart';
import '../../../../../main.dart';
import '../../../domain/entities/order.entity.dart';
import '../../../domain/use_cases/get_orders_by_category.usecase.dart';

part 'order_event.dart';

part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final GetOrdersByStageUsecase getOrdersByStage = locator();
  final GetOrdersUsecase getOrdersUsecase = locator();

  OrderBloc() : super(OrderState.initial()) {
    // * events
    on<InitiaclEvent>((event, emit) => _onInitiaclEvent(event, emit));
    on<ChangeCurrentStageEvent>((event, emit) => _onChangeCurrentStageEvent(event, emit));
  }

  _onInitiaclEvent(InitiaclEvent event, Emitter<OrderState> emit) async {
    emit(state.copyWith(newStatus: Status.LOADING));
    final DataState<List<OrderEntity>> result = await getOrdersUsecase();
    if (result is DataSuccess) {
      emit(state.copyWith(newOrders: result.data, newStatus: Status.SUCCESS));
    } else {
      emit(state.copyWith(newStatus: Status.ERROR, newMessage: result.error));
    }
  }

  _onChangeCurrentStageEvent(ChangeCurrentStageEvent event, Emitter<OrderState> emit) async {
    emit(state.copyWith(newStatus: Status.LOADING, newCurrentCategory: event.categoryId));
    final DataState<List<OrderEntity>> result = await getOrdersByStage(event.categoryId);
    if (result is DataSuccess) {
      emit(state.copyWith(newOrders: result.data, newStatus: Status.SUCCESS));
    } else {
      emit(state.copyWith(newStatus: Status.ERROR, newMessage: result.error));
    }
  }
}
