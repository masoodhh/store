part of 'order_bloc.dart';

abstract class OrderEvent {}

class InitiaclEvent extends OrderEvent {}

class ChangeCurrentCategoryEvent extends OrderEvent {
  final int categoryId;

  ChangeCurrentCategoryEvent({required this.categoryId});
}
