part of 'order_bloc.dart';

abstract class OrderEvent {}

class InitiaclEvent extends OrderEvent {}

class ChangeCurrentStageEvent extends OrderEvent {
  final int categoryId;

  ChangeCurrentStageEvent({required this.categoryId});
}

class AddOrderEvent extends OrderEvent {
  final OrderEntity orderEntity;

  AddOrderEvent({required this.orderEntity});
}
