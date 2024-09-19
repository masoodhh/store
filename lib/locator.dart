import 'package:get_it/get_it.dart';
import 'package:store/features/home_page/data/repositories/home_products_repository_impl_local.dart';
import 'package:store/features/home_page/domain/repositories/home_products_repository.dart';
import 'package:store/features/home_page/domain/use_cases/get_categories_usecase.dart';
import 'package:store/features/home_page/domain/use_cases/get_products_by_category_usecase.dart';
import 'package:store/features/home_page/presentation/manager/cart/cart_bloc.dart';
import 'package:store/features/home_page/presentation/manager/home/home_bloc.dart';

import 'features/home_page/presentation/manager/tab/tab_cubit.dart';

GetIt locator = GetIt.instance;

setup() async {
  // ! Repositories
  locator.registerSingleton<HomeProductsRepository>(HomeProductsRepositoryImplLocal());

  // ! UseCases
  locator.registerSingleton<GetProductsByCategoryUsecase>(GetProductsByCategoryUsecase(locator()));
  locator.registerSingleton<GetCategoriesUsecase>(GetCategoriesUsecase(locator()));
  // ! State Managers
  locator.registerSingleton<HomeBloc>(HomeBloc(locator(), locator()));
  locator.registerSingleton<CartBloc>(CartBloc());
  locator.registerSingleton<TabCubit>(TabCubit());
}
