part of 'home_bloc.dart';

abstract class HomeEvent {}

class ChangeCategoryEvent extends HomeEvent {
  final int categoryId;

  ChangeCategoryEvent(this.categoryId);
}
class InitializeEvent extends HomeEvent {}