import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:store/core/manager/cart/cart_bloc.dart';
import 'package:store/features/cart_page/domin/entities/address_entity.dart';
import 'package:store/features/cart_page/domin/entities/icon_data_adapter.dart';
import 'package:store/features/cart_page/domin/entities/payment_card_entity.dart';
import 'package:store/features/cart_page/presentation/manager/checkout/checkout_bloc.dart';
import 'package:store/features/home_page/presentation/manager/home/home_bloc.dart';
import 'package:store/features/home_page/presentation/manager/tab/tab_cubit.dart';
import 'package:store/pages/splash_screen.dart';
import 'features/home_page/data/repositories/home_products_repository_impl_local.dart';
import 'features/home_page/domain/repositories/home_products_repository.dart';
import 'features/home_page/domain/use_cases/get_categories_usecase.dart';
import 'features/home_page/domain/use_cases/get_products_by_category_usecase.dart';
import 'features/home_page/presentation/pages/home_page.dart';

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
          create: (context) => locator<TabCubit>(),
        ),
        BlocProvider(
          create: (context) => locator<CheckoutBloc>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false, // Remove this line to disable debug mode banner
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: SplashScreen(),
      )));
}
