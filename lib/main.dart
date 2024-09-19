import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/features/home_page/presentation/manager/cart/cart_bloc.dart';
import 'package:store/features/home_page/presentation/manager/home/home_bloc.dart';
import 'package:store/features/home_page/presentation/manager/tab/tab_cubit.dart';
import 'features/home_page/presentation/pages/home_page.dart';
import 'locator.dart';

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
        ),BlocProvider(
          create: (context) => locator<TabCubit>(),
        ),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false, // Remove this line to disable debug mode banner
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: HomePage(),
      )));
}
