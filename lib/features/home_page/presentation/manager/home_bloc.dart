import 'package:bloc/bloc.dart';
import 'package:store/features/home_page/domain/use_cases/get_products_by_category_usecase.dart';
import 'package:store/pages/home_page.dart';

import '../../../../core/resources/data_state.dart';
import '../../data/models/home_products_model.dart' as home_products_model;

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetProductsByCategoryUsecase getProductsByCategoryUsecase;

  HomeBloc(this.getProductsByCategoryUsecase) : super(HomeInitState()) {
    on<ChangeCategoryEvent>((event, emit) async {
      emit(HomeLoadingState());
      final DataState<home_products_model.HomeProductsModel> dataState =
          await getProductsByCategoryUsecase(event.categoryId);

      if (dataState is DataSuccess) {
        final home_products_model.HomeProductsModel? model = dataState.data;
        // TODO:خودت مشکل رو حل کن
        emit(HomeLoadedState.fromModel(model: model!, categories: state.categories));
      }
    });
  }
}
