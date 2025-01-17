part of 'main.dart';

GetIt locator = GetIt.instance;

setup() async {
  await Hive.initFlutter(); // مقداردهی اولیه Hive
  Hive.registerAdapter(IconDataAdapter());
  Hive.registerAdapter(AddressEntityAdapter());
  Hive.registerAdapter(PaymentCardEntityAdapter());
  // ! DataProvider
  if (Constants.DATA_SOURCE == 0) {
    locator.registerSingleton<local_provider.DataProvider>(local_provider.DataProvider());
    locator.registerSingleton<OrderDataProviderLocal>(OrderDataProviderLocal());
    // ! Repositories
    locator.registerSingleton<HomeRepository>(HomeRepositoryImpl(locator<local_provider.DataProvider>()));
    locator.registerSingleton<OrderRepository>(OrderRepositoryImpl(locator<OrderDataProviderLocal>()));
  } else {
    locator.registerSingleton<remote_provider.DataProvider>(remote_provider.DataProvider());
    locator.registerSingleton<OrderDataProviderRemote>(OrderDataProviderRemote());
    // ! Repositories
    locator.registerSingleton<HomeRepository>(HomeRepositoryImpl(locator<remote_provider.DataProvider>()));
    locator.registerSingleton<OrderRepository>(OrderRepositoryImpl(locator<OrderDataProviderRemote>()));
  }

  // ! UseCases
  locator.registerSingleton<GetProductsByCategoryUsecase>(GetProductsByCategoryUsecase(locator()));
  locator.registerSingleton<GetCategoriesUsecase>(GetCategoriesUsecase(locator()));
  locator.registerSingleton<GetSearchedProductsUsecase>(GetSearchedProductsUsecase(locator()));
  locator.registerSingleton<GetRecentlySearchedUsecase>(GetRecentlySearchedUsecase(locator()));
  locator.registerSingleton<AddRecentlySearchedUsecase>(AddRecentlySearchedUsecase(locator()));

  locator.registerSingleton<GetProductDetailUsecase>(GetProductDetailUsecase(locator()));

  locator.registerSingleton<GetOrdersUsecase>(GetOrdersUsecase(locator()));
  locator.registerSingleton<GetOrdersByStageUsecase>(GetOrdersByStageUsecase(locator()));
  locator.registerSingleton<AddOrderUsecase>(AddOrderUsecase(locator()));
  // ! State Managers
  locator.registerSingleton<HomeBloc>(HomeBloc());
  locator.registerSingleton<SearchBloc>(SearchBloc());
  locator.registerSingleton<CartBloc>(CartBloc());
  locator.registerSingleton<PageWrapperCubit>(PageWrapperCubit());
  locator.registerSingleton<CheckoutBloc>(CheckoutBloc());
  locator.registerSingleton<OrderBloc>(OrderBloc());
  locator.registerSingleton<ProductCubit>(ProductCubit());
}
