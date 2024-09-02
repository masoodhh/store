import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:store/features/home_page/domain/use_cases/get_products_by_category_usecase.dart';
import 'package:store/pages/home_page.dart';

import '../../../../core/resources/data_state.dart';
import '../../data/models/home_products_model.dart' as home_products_model;

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetProductsByCategoryUsecase getProductsByCategoryUsecase;

  HomeBloc(this.getProductsByCategoryUsecase)
      : super(HomeState(
            categoryState: CategoryInitState(),
            productState: ProductInitState())) {
    on<ChangeCategoryEvent>((event, emit) async {
      emit(HomeState(
          categoryState: CategoryLoadingState(),
          productState: ProductLoadingState()));

      //TODO: دو مورد زیر را تست کن هر کدوم گرفت همونو بزار ترجیحا اولی رو بزار
      emit(state.copyWith(
        newCategoryState:
            (state.categoryState as CategoryLoadedState).OnChanged(
          event.categoryId,
        ),
      ));

      emit(state.copyWith(
        newCategoryState:
            (state.categoryState as CategoryLoadedState).changeSelect(
          event.categoryId,
        ),
      ));

      final DataState<home_products_model.HomeProductsModel> dataState =
          await getProductsByCategoryUsecase(event.categoryId);

      if (dataState is DataSuccess) {
        final home_products_model.HomeProductsModel? model = dataState.data;

        //TODO: دو مورد زیر را تست کن هر کدوم گرفت همونو بزار ترجیحا اولی رو بزار
        emit(state.copyWith(
            newCategoryState:
                (state.categoryState as CategoryLoadedState).OnChanged(
              event.categoryId,
            ),
            newProductState: ProductLoadedState.fromModel(model: model!)));

        emit(state.copyWith(
            newCategoryState:
                (state.categoryState as CategoryLoadedState).changeSelect(
              event.categoryId,
            ),
            newProductState: ProductLoadedState.fromModel(model: model!)));
        emit(HomeLoadedState.fromModel(
            model: model!, categories: state.categories));
      }
    });
  }
}
