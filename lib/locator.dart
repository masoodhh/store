part of 'main.dart';

GetIt locator = GetIt.instance;

setup() async {
  await Hive.initFlutter(); // مقداردهی اولیه Hive
  Hive.registerAdapter(IconDataAdapter());
  Hive.registerAdapter(AddressEntityAdapter());
  Hive.registerAdapter(PaymentCardEntityAdapter());

  // ! Repositories
  locator.registerSingleton<HomeRepository>(HomeRepositoryImplLocal());
  locator.registerSingleton<OrderRepository>(OrderRepositoryImpl());

  // ! UseCases
  locator.registerSingleton<GetProductsByCategoryUsecase>(GetProductsByCategoryUsecase(locator()));
  locator.registerSingleton<GetCategoriesUsecase>(GetCategoriesUsecase(locator()));
  locator.registerSingleton<GetSearchedProductsUsecase>(GetSearchedProductsUsecase(locator()));
  locator.registerSingleton<GetRecentlySearchedUsecase>(GetRecentlySearchedUsecase(locator()));
  locator.registerSingleton<AddRecentlySearchedUsecase>(AddRecentlySearchedUsecase(locator()));

  locator.registerSingleton<GetOrdersUsecase>(GetOrdersUsecase(locator()));
  locator.registerSingleton<GetOrdersByCategoryUsecase>(GetOrdersByCategoryUsecase(locator()));
  // ! State Managers
  locator.registerSingleton<HomeBloc>(HomeBloc());
  locator.registerSingleton<SearchBloc>(SearchBloc());
  locator.registerSingleton<CartBloc>(CartBloc());
  locator.registerSingleton<PageWrapperCubit>(PageWrapperCubit());
  locator.registerSingleton<CheckoutBloc>(CheckoutBloc());
  locator.registerSingleton<OrderBloc>(OrderBloc());
}
