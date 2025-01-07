import 'package:bloc/bloc.dart';
import 'package:store/core/resources/data_state.dart';
import 'package:store/features/home/domain/entities/category_entity.dart';
import 'package:store/features/home/domain/entities/product_entity.dart';
import 'package:store/features/search/domain/use_cases/add_recently_searched.usecase.dart';
import 'package:store/features/search/domain/use_cases/get_recently_searched.usecase.dart';

import '../../../../../core/params/params.dart';
import '../../../../../logger.dart';
import '../../../../../main.dart';
import '../../../../home/domain/use_cases/get_categories_usecase.dart';
import '../../../domain/use_cases/get_searched_products.usecase.dart';

part 'search_state.dart';

part 'search_event.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final GetSearchedProductsUsecase getSearchedProductsUsecase = locator();
  final GetCategoriesUsecase getCategoriesUsecase = locator();
  final GetRecentlySearchedUsecase getRecentlySearchedUsecase = locator();
  final AddRecentlySearchedUsecase addRecentlySearchedUsecase = locator();

  SearchBloc() : super(SearchState.init()) {
    // * events
    on<InicialEvent>((event, emit) => _onInicialEvent(event, emit));
    on<ChangeSearchTextEvent>((event, emit) => _onChangeSearchTextEvent(event, emit));
    on<ChangeSearchCategoryEvent>((event, emit) => _onChangeSearchCategoryEvent(event, emit));
    on<ChangeSearchPriceEvent>((event, emit) => _onChangeSearchPriceEvent(event, emit));
    on<ChooseRecentSearchEvent>((event, emit) => _onChooseRecentSearchEvent(event, emit));
    on<ConfirmSearchEvent>((event, emit) => _onConfirmSearchEvent(event, emit));
  }

  _onInicialEvent(InicialEvent event, Emitter<SearchState> emit) async {
    final DataState<List<CategoryEntity>> dataState = await getCategoriesUsecase();

    if (dataState is DataSuccess) {
      List<CategoryEntity> categories = [CategoryEntity(id: 0, title: "All Categories", isChecked: true)];
      categories.addAll(dataState.data!);
      emit(state.copyWith(
        newCategories: categories,
      ));
    }
    final List<String> data = await getRecentlySearchedUsecase();
    emit(state.copyWith(
      newRecentlySearches: data,
    ));

    //TODO:
    // final List<String> result=getRecentSearchUsecase;
    // emit(state.copyWith(newRecentlySearches: result));
  }

  _onChangeSearchTextEvent(ChangeSearchTextEvent event, Emitter<SearchState> emit) {
    state.searchFilter.text = event.text;
  }

  _onChangeSearchCategoryEvent(ChangeSearchCategoryEvent event, Emitter<SearchState> emit) {
    for (var category in state.categories) {
      category.id == event.categoryId ? category.isChecked = true : category.isChecked = false;
    }
    emit(state.copyWith(newSearchFilter: SearchFilter.copyWith(categoryId: event.categoryId)));
  }

  _onChangeSearchPriceEvent(ChangeSearchPriceEvent event, Emitter<SearchState> emit) {
    emit(state.copyWith(
        newSearchFilter: SearchFilter.copyWith(minPrice: event.minPrice, maxPrice: event.maxPrice)));
  }

  _onChooseRecentSearchEvent(ChooseRecentSearchEvent event, Emitter<SearchState> emit) {
    state.searchFilter.text = event.text;
  }

  _onConfirmSearchEvent(ConfirmSearchEvent event, Emitter<SearchState> emit) async {
    //TODO:
    if (state.searchFilter.text?.isEmpty ?? true) {
      return;
    }
    emit(state.copyWith(newStatus: Status.LOADING));
    await addRecentlySearchedUsecase(state.searchFilter.text!);
    state.recentlySearches.removeWhere((element) => element == state.searchFilter.text);
    state.recentlySearches.insert(0, state.searchFilter.text!);
    final DataState<List<ProductEntity>> result = await getSearchedProductsUsecase(state.searchFilter);
    if (result is DataSuccess) {
      final newProducts = (result as DataSuccess<List<ProductEntity>>).data!;
      if (newProducts.isEmpty) {
        emit(state.copyWith(newStatus: Status.INITIAL, newProducts: []));
      } else {
        emit(state.copyWith(newStatus: Status.SUCCESS, newProducts: newProducts));
      }
    }
    if (result is DataFailed) {
      final String error = (result as DataFailed).error!;
      emit(state.copyWith(newStatus: Status.ERROR, newMessage: error));
    }
  }
}
