part of 'search_bloc.dart';

class SearchState {
  final Status status;
  final SearchFilter searchFilter;
  final List<ProductEntity> products;
  final List<CategoryEntity> categories;
  final List<String> recentlySearches;
  final String? message;

  SearchState(
      {required this.status,
      required this.products,
      required this.searchFilter,
      this.categories = const [],
      this.recentlySearches = const [],
      this.message});

  SearchState copyWith(
      {Status? newStatus,
      List<ProductEntity>? newProducts,
      SearchFilter? newSearchFilter,
      List<String>? newRecentlySearches,
      List<CategoryEntity>? newCategories,
      String? newMessage}) {
    return SearchState(
      status: newStatus ?? status,
      products: newProducts ?? products,
      searchFilter: newSearchFilter != null ? searchFilter._copyWith(newSearchFilter) : searchFilter,
      recentlySearches: newRecentlySearches ?? recentlySearches,
      categories: newCategories ?? categories,
      message: newMessage,
    );
  }

  factory SearchState.init() {
    return SearchState(
      status: Status.INITIAL,
      searchFilter: SearchFilter(),
      products: [],
      categories: [],
      recentlySearches: [],
    );
  }
}

class SearchFilter {
  String? text;
  final bool? isPriceEnabled;
  final double? minPrice;
  final double? maxPrice;
  final int? categoryId;

  SearchFilter(
      {this.text = "", this.isPriceEnabled = false, this.minPrice, this.maxPrice, this.categoryId = 0});

  SearchFilter.copyWith({this.text, this.isPriceEnabled, this.minPrice, this.maxPrice, this.categoryId});

  _copyWith(SearchFilter newSearchFilter) {
    return SearchFilter(
      text: newSearchFilter.text ?? text,
      isPriceEnabled: newSearchFilter.isPriceEnabled ?? isPriceEnabled,
      minPrice: newSearchFilter.minPrice ?? minPrice,
      maxPrice: newSearchFilter.maxPrice ?? maxPrice,
      categoryId: newSearchFilter.categoryId ?? categoryId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'isPriceEnabled':( minPrice!=null || maxPrice !=null)? true : false,
      'minPrice': minPrice,
      'maxPrice': maxPrice,
      'categoryId': categoryId == 0 ? null : categoryId,
    };
  }
}
