part of 'home_bloc.dart';

abstract class HomeEvent {}

class ChangeCategoryEvent extends HomeEvent {
  final Category category;

  ChangeCategoryEvent(this.category);
}
