import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/params/colors.dart';
import '../../../cart/presentation/pages/cart_tab.dart';
import '../../../order/presentation/pages/orders_tab.view.dart';
import '../manager/home/home_bloc.dart';
import '../manager/page_wrapper/page_wrapper.cubit.dart';
import 'home_tab.view.dart';

class PageWrapper extends StatefulWidget {
  const PageWrapper({super.key});

  static const routeName = '/home';

  @override
  State<PageWrapper> createState() => _PageWrapperState();
}

class _PageWrapperState extends State<PageWrapper> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    BlocProvider.of<PageWrapperCubit>(context).changeTab(0);
    BlocProvider.of<HomeBloc>(context).add(InitializeEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBody() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: MyColors.primaryColor,
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
          color: Colors.white,
        ),
        padding: const EdgeInsets.all(10),
        child: PageView(
          controller: _pageController,
          children: [
            const HomeTab(),
            const OrdersTab(),
            const CartTab(),
            _gifsTab(),
          ],
        ),
      ),
    );
  }

  Widget _gifsTab() {
    return const Center(
      child: Text(
        "Gift Tab",
        style: TextStyle(fontSize: 40, color: Colors.black),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      height: 70,
      color: MyColors.primaryColor,
      child: Center(
        child: BlocBuilder<PageWrapperCubit, int>(
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildBottomNavItem(0, _pageController, state == 0, Icons.home, "Home"),
                _buildBottomNavItem(1, _pageController, state == 1, Icons.list, "Orders"),
                _buildBottomNavItem(2, _pageController, state == 2, Icons.shopping_cart, "My Cart"),
                _buildBottomNavItem(3, _pageController, state == 3, Icons.search, "Search"),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildBottomNavItem(
      int index, PageController pageController, bool selected, IconData icon, String title) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          BlocProvider.of<PageWrapperCubit>(context).changeTab(index);
          pageController.jumpToPage(index);
        },
        child: Container(
          color: Colors.transparent,
          margin: const EdgeInsets.symmetric(horizontal: 3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: selected ? Colors.white : Colors.grey,
              ),
              Text(
                title,
                style: TextStyle(
                  color: selected ? Colors.white : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
