import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import '../../../../../core/params/params.dart';
import '../../../../../main.dart';
import '../../../domain/entities/category_entity.dart';
import '../../../domain/entities/product_entity.dart';
import '../../../../../core/resources/data_state.dart';
import '../../../domain/use_cases/get_categories_usecase.dart';
import '../../../domain/use_cases/get_products_by_category_usecase.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetProductsByCategoryUsecase getProductsByCategoryUsecase=locator();
  final GetCategoriesUsecase getCategoriesUsecase=locator();
  Logger logger = Logger();

  HomeBloc() : super(HomeState.init()) {
    // * events
    on<InitializeEvent>((event, emit) => _initializeEvent(event, emit));
    on<ChangeCategoryEvent>((event, emit) => _changeCategoryEvent(event, emit));
  }

  FutureOr<void> _initializeEvent(InitializeEvent event, Emitter<HomeState> emit) async {
    emit(HomeState(
        categoryState: state.categoryState.copyWith(newStatus: Status.LOADING),
        productState: state.productState.copyWith(newStatus: Status.LOADING)));
    try {
      final DataState<List<CategoryEntity>> dataState = await getCategoriesUsecase();

      if (dataState is DataSuccess) {
        List<CategoryEntity> categories = [CategoryEntity(id: 0, title: "All Categories", isChecked: true)];
        categories.addAll(dataState.data!);
        emit(state.copyWith(
          newCategoryState: CategoryState(categories: categories, status: Status.SUCCESS),
        ));
        _fetchProducts(categories.first.id!);
      } else {
        _handleFetchError();
      }
    } on Exception catch (e) {
      _handleFetchError();
    }
  }

  FutureOr<void> _changeCategoryEvent(ChangeCategoryEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(
        newCategoryState: state.categoryState.copyWith(newStatus: Status.LOADING),
        newProductState: state.productState.copyWith(newStatus: Status.LOADING)));

    emit(state.copyWith(
      newCategoryState: state.categoryState.OnChanged(event.categoryId, Status.SUCCESS),
    ));

    try {
      final DataState<List<ProductEntity>> dataState = await getProductsByCategoryUsecase(event.categoryId);
      if (dataState is DataSuccess) {
        final List<ProductEntity> products = dataState.data!;
        emit(state.copyWith(
          newProductState: ProductState(products: products, status: Status.SUCCESS),
        ));
      } else {
        _handleFetchError();
      }
    } on Exception catch (e) {
      _handleFetchError();
    }
  }

  void _fetchProducts(int categoryId) async {
    try {
      final DataState<List<ProductEntity>> dataState = await getProductsByCategoryUsecase(categoryId);

      if (dataState is DataSuccess) {
        final List<ProductEntity> products = dataState.data!;
        emit(state.copyWith(
          newProductState: ProductState(products: products, status: Status.SUCCESS),
          newCategoryState: CategoryState(categories: state.categoryState.categories, status: Status.SUCCESS),
        ));
      } else {
        _handleFetchError();
      }
    } on Exception catch (e) {
      _handleFetchError();
    }
  }

  void _handleFetchError() {
    emit(state.copyWith(newProductState: state.productState.copyWith(newStatus: Status.ERROR)));
  }
}
