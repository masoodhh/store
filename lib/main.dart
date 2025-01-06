import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:store/core/manager/cart/cart_bloc.dart';
import 'package:store/features/auth/presentation/pages/login.view.dart';
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
import 'features/order/presentation/pages/orders_details.view.dart';


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
          OrderDetailsPage.routeName: (context) => OrderDetailsPage(),
        },
      )));
}
