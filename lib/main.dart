import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:store/core/manager/cart/cart_bloc.dart';
import 'package:store/core/params/constants.dart';
import 'package:store/features/auth/presentation/pages/login.view.dart';
import 'package:store/features/home/data/data_sources/local/data_provider.dart' as local_provider;
import 'package:store/features/home/data/data_sources/remote/data_provider.dart' as remote_provider;
import 'package:store/features/order/data/repositories/order.repository_impl.dart';
import 'package:store/features/order/presentation/manager/order/order_bloc.dart';
import 'package:store/features/product/domin/use_cases/get_product_detail_usecase.dart';
import 'package:store/features/product/presentation/manager/product/product_cubit.dart';
import 'package:store/features/search/domain/use_cases/get_searched_products.usecase.dart';
import 'package:store/features/search/presentation/manager/search/search_bloc.dart';
import 'package:store/features/splash/presentation/pages/splash_screen.view.dart';
import 'package:store/features/splash/presentation/pages/welcome.view.dart';
import 'features/auth/presentation/pages/register.view.dart';
import 'features/cart/domin/entities/address_entity.dart';
import 'features/cart/domin/entities/icon_data_adapter.dart';
import 'features/cart/domin/entities/payment_card_entity.dart';
import 'features/cart/presentation/manager/checkout/checkout_bloc.dart';
import 'features/cart/presentation/pages/check_out_page.dart';
import 'features/home/data/repositories/home.repository_impl.dart';
import 'features/home/domain/repositories/home.repository.dart';
import 'features/home/domain/use_cases/get_categories_usecase.dart';
import 'features/home/domain/use_cases/get_products_by_category_usecase.dart';
import 'features/home/presentation/manager/home/home_bloc.dart';
import 'features/home/presentation/manager/page_wrapper/page_wrapper.cubit.dart';
import 'features/home/presentation/pages/page_wrapper.view.dart';
import 'features/order/data/data_sources/order_data_provider.dart';
import 'features/order/data/data_sources/remote/order_data_provider.dart';
import 'features/order/domain/repositories/order.repository.dart';
import 'features/order/domain/use_cases/add_order.usecase.dart';
import 'features/order/domain/use_cases/get_orders.usecase.dart';
import 'features/order/domain/use_cases/get_orders_by_category.usecase.dart';
import 'features/order/presentation/pages/orders_details.view.dart';
import 'features/search/domain/use_cases/add_recently_searched.usecase.dart';
import 'features/search/domain/use_cases/get_recently_searched.usecase.dart';


part 'locator.dart';

void main() async {
  // ! init locator
  await setup();
  runApp(MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => locator<HomeBloc>(),
        ),
        BlocProvider(
          create: (context) => locator<CartBloc>(),
        ),
        BlocProvider(
          create: (context) => locator<PageWrapperCubit>(),
        ),
        BlocProvider(
          create: (context) => locator<CheckoutBloc>(),
        ),BlocProvider(
          create: (context) => locator<SearchBloc>(),
        ),BlocProvider(
          create: (context) => locator<OrderBloc>(),
        ),BlocProvider(
          create: (context) => locator<ProductCubit>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // Remove this line to disable debug mode banner
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: SplashScreen.routeName,
        routes: {
          SplashScreen.routeName: (context) => SplashScreen(),
          PageWrapper.routeName: (context) => PageWrapper(),
          WelcomePage.routeName: (context) => WelcomePage(),
          RegisterPage.routeName: (context) => RegisterPage(),
          LoginPage.routeName: (context) => LoginPage(),
          CheckOutPage.routeName: (context) => CheckOutPage(),
          // OrderDetailsPage.routeName: (context) => OrderDetailsPage(),
        },
      )));
}
