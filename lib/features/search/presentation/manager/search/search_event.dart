part of 'search_bloc.dart';

abstract class SearchEvent {}

class InicialEvent extends SearchEvent {}
class ChangeSearchTextEvent extends SearchEvent {
  final String text;

  ChangeSearchTextEvent(this.text);
}

class ChangeSearchMinPriceEvent extends SearchEvent {
  final double minPrice;

  ChangeSearchMinPriceEvent(this.minPrice);
}

class ChangeSearchMaxPriceEvent extends SearchEvent {
  final double maxPrice;

  ChangeSearchMaxPriceEvent(this.maxPrice);
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
