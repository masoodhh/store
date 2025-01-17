part of 'order_bloc.dart';

abstract class OrderEvent {}

class InitiaclEvent extends OrderEvent {}

class ChangeCurrentStageEvent extends OrderEvent {
  final int categoryId;
  final int categoryIndex;

  ChangeCurrentStageEvent({required this.categoryId,required this.categoryIndex});
}

class AddOrderEvent extends OrderEvent {
  final OrderEntity orderEntity;

  AddOrderEvent({required this.orderEntity});
}
