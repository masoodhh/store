part of 'search_bloc.dart';

abstract class SearchEvent {}

class InicialEvent extends SearchEvent {}

class ChangeSearchTextEvent extends SearchEvent {
  final String text;

  ChangeSearchTextEvent(this.text);
}

class ChangeSearchPriceEvent extends SearchEvent {
  final double maxPrice;
  final double minPrice;

  ChangeSearchPriceEvent({required this.minPrice, required this.maxPrice});
}

class ChangeSearchCategoryEvent extends SearchEvent {
  final int categoryId;

  ChangeSearchCategoryEvent(this.categoryId);
}

class ChooseRecentSearchEvent extends SearchEvent {
  final String text;

  ChooseRecentSearchEvent(this.text);
}

class ConfirmSearchEvent extends SearchEvent {}
