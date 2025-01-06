part of 'main.dart';

GetIt locator = GetIt.instance;

setup() async {
  await Hive.initFlutter(); // مقداردهی اولیه Hive
  Hive.registerAdapter(IconDataAdapter());
  Hive.registerAdapter(AddressEntityAdapter());
  Hive.registerAdapter(PaymentCardEntityAdapter());

  // ! Repositories
  locator.registerSingleton<HomeRepository>(HomeRepositoryImplLocal());

  // ! UseCases
  locator.registerSingleton<GetProductsByCategoryUsecase>(GetProductsByCategoryUsecase(locator()));
  locator.registerSingleton<GetCategoriesUsecase>(GetCategoriesUsecase(locator()));
  locator.registerSingleton<GetSearchedProductsUsecase>(GetSearchedProductsUsecase(locator()));
  // ! State Managers
  locator.registerSingleton<HomeBloc>(HomeBloc());
  locator.registerSingleton<SearchBloc>(SearchBloc());
  locator.registerSingleton<CartBloc>(CartBloc());
  locator.registerSingleton<PageWrapperCubit>(PageWrapperCubit());
  locator.registerSingleton<CheckoutBloc>(CheckoutBloc());
}
