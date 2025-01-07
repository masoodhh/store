part of 'order_bloc.dart';

class OrderState {
  final List<OrderEntity> orders;
  final Status status;
  final int currentCategory; //0:all ,1:pending , 2:processing
  final String? message;

  OrderState({required this.orders, required this.status, required this.currentCategory, this.message});

  OrderState copyWith(
      {List<OrderEntity>? newOrders, Status? newStatus, int? newCurrentCategory, String? newMessage}) {
    return OrderState(
      orders: newOrders ?? orders,
      status: newStatus ?? status,
      currentCategory: newCurrentCategory ?? currentCategory,
      message: newMessage,
    );
  }

  factory OrderState.initial() => OrderState(
        orders: [],
        status: Status.INITIAL,
        currentCategory: 0,
      );
}
