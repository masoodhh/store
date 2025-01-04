part of 'main.dart';

GetIt locator = GetIt.instance;

setup() async {
  await Hive.initFlutter(); // مقداردهی اولیه Hive
  Hive.registerAdapter(IconDataAdapter());
  Hive.registerAdapter(AddressEntityAdapter());
  Hive.registerAdapter(PaymentCardEntityAdapter());

  // ! Repositories
  locator.registerSingleton<HomeProductsRepository>(HomeProductsRepositoryImplLocal());

  // ! UseCases
  locator.registerSingleton<GetProductsByCategoryUsecase>(GetProductsByCategoryUsecase(locator()));
  locator.registerSingleton<GetCategoriesUsecase>(GetCategoriesUsecase(locator()));
  // ! State Managers
  locator.registerSingleton<HomeBloc>(HomeBloc(locator(), locator()));
  locator.registerSingleton<CartBloc>(CartBloc());
  locator.registerSingleton<WrapperCubit>(WrapperCubit());
  locator.registerSingleton<CheckoutBloc>(CheckoutBloc());
}
