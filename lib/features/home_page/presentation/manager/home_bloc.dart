import 'package:bloc/bloc.dart';
import 'package:store/features/home_page/domain/use_cases/get_products_by_category_usecase.dart';

import '../../../../core/resources/data_state.dart';
import '../../data/models/home_products_model.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetProductsByCategoryUsecase getProductsByCategoryUsecase;

  HomeBloc(this.getProductsByCategoryUsecase) : super(HomeInitState()) {
    on<ChangeCategoryEvent>((event, emit) async {
      emit(HomeLoadingState());
      final DataState<List<HomeProductsModel>> dataState =
          await getProductsByCategoryUsecase(event.category);

      if (dataState is DataSuccess) {
        emit(HomeLoadedState(products: dataState.data));
      }
    });
  }
}
