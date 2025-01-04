import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:store/features/home_page/domain/use_cases/get_categories_usecase.dart';
import 'package:store/features/home_page/domain/use_cases/get_products_by_category_usecase.dart';
import '../../../../../core/params/params.dart';
import '../../../domain/entities/category_entity.dart';
import '../../../domain/entities/product_entity.dart';
import '../../../../../core/resources/data_state.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetProductsByCategoryUsecase getProductsByCategoryUsecase;
  final GetCategoriesUsecase getCategoriesUsecase;
  Logger logger = Logger();

  HomeBloc(this.getProductsByCategoryUsecase, this.getCategoriesUsecase) : super(HomeState.init()) {
    // * events

    // ! InitializeEvent
    on<InitializeEvent>((event, emit) async {
      emit(HomeState(
          categoryState: state.categoryState.copyWith(newStatus: Status.LOADING),
          productState: state.productState.copyWith(newStatus: Status.LOADING)));
      try {
        final DataState<List<CategoryEntity>> dataState = await getCategoriesUsecase();

        if (dataState is DataSuccess) {
          // final List<CategoryEntity> categories = dataState.data!;
          List<CategoryEntity> categories = [CategoryEntity(id: 0, title: "All Categories", isChecked: true)];
          categories.addAll(dataState.data!);
          emit(state.copyWith(
            newCategoryState: CategoryState(categories: categories, status: Status.SUCCESS),
          ));
          final DataState<List<ProductEntity>> dataState2 =
              await getProductsByCategoryUsecase(categories.first.id!);

          if (dataState2 is DataSuccess) {
            final List<ProductEntity> products = dataState2.data!;

            emit(state.copyWith(
              newProductState: ProductState(products: products, status: Status.SUCCESS),
            ));
          } else {
            emit(state.copyWith(
              newProductState: ProductState(products: [], status: Status.ERROR),
            ));
          }
        } else {
          emit(state.copyWith(
            newCategoryState: CategoryState(categories: [], status: Status.ERROR),
            newProductState: ProductState(products: [], status: Status.ERROR),
          ));
        }
      } on Exception catch (e) {
        emit(state.copyWith(
          newProductState: ProductState(products: [], status: Status.ERROR),
        ));
      }
    });
    // ! ChangeCategoryEvent
    on<ChangeCategoryEvent>((event, emit) async {
      logger.i("ChangeCategoryEvent1");
      emit(HomeState(
          categoryState: state.categoryState.copyWith(newStatus: Status.LOADING),
          productState: state.productState.copyWith(newStatus: Status.LOADING)));
      logger.i("ChangeCategoryEvent2");
      logger.i("event.categoryId " + event.categoryId.toString());

      //TODO: دو مورد زیر را تست کن هر کدوم گرفت همونو بزار ترجیحا اولی رو بزار
      emit(state.copyWith(
        newCategoryState: state.categoryState.OnChanged(event.categoryId, Status.SUCCESS),
      ));
      logger.i("ChangeCategoryEvent3");

/*      emit(state.copyWith(
        newCategoryState: state.categoryState.changeSelect(
          event.categoryId,
        ),
      ));*/

      try {
        final DataState<List<ProductEntity>> dataState = await getProductsByCategoryUsecase(event.categoryId);
        logger.i("ChangeCategoryEvent4");

        if (dataState is DataSuccess) {
          final List<ProductEntity> products = dataState.data!;

          //TODO: دو مورد زیر را تست کن هر کدوم گرفت همونو بزار ترجیحا اولی رو بزار
          emit(state.copyWith(
            newProductState: ProductState(products: products, status: Status.SUCCESS),
          ));
          // newProductState: ProductLoadedState.fromModel(model: model!)));
        } else {
          emit(state.copyWith(
            newProductState: ProductState(products: [], status: Status.ERROR),
          ));
        }
      } on Exception catch (e) {
        emit(state.copyWith(
          newProductState: ProductState(products: [], status: Status.ERROR),
        ));
      }
    });
  }
}
