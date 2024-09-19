import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/features/home_page/presentation/manager/home/home_bloc.dart';
import 'package:store/features/home_page/presentation/manager/tab/tab_cubit.dart';
import 'package:store/features/home_page/presentation/widgets/tabs/cart_tab.dart';
import 'package:store/features/home_page/presentation/widgets/tabs/orders_tab.dart';

import '../widgets/tabs/home_tab.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final PageController _pageController ;

  @override
  void initState() {
    super.initState();
    _pageController= PageController(initialPage: 0);
    BlocProvider.of<TabCubit>(context).changeTab(0);
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
      color: const Color(0xFF18263E),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
          color: Colors.white,
        ),
        padding: const EdgeInsets.all(10),
        child: PageView(
          controller: _pageController,
          children: [
            HomeTab(),
            OrdersTab(),
            CartTab(),
            _buildGiftPage(),
          ],
        ),
      ),
    );
  }

  /*Widget _buildHomePage() {
    // Return the existing home page content
  }*/

  Widget _buildProfilePage() {
    return Container(
      child: Center(child: Text("profile")),
    );
  }

  Widget _buildGiftPage() {
    return Container(
      child: Center(child: Text("gifts")),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      height: 70,
      color: const Color(0xFF18263E),
      child: Center(
        child: BlocBuilder<TabCubit, int>(
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildBottomNavItem(0, _pageController, state == 0, Icons.home, "Home"),
                _buildBottomNavItem(1, _pageController, state == 1, Icons.list, "Orders"),
                _buildBottomNavItem(2, _pageController, state == 2, Icons.shopping_cart, "My Cart"),
                _buildBottomNavItem(3, _pageController, state == 3, Icons.gif_box, "Gift"),
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
          BlocProvider.of<TabCubit>(context).changeTab(index);
          pageController.jumpToPage(index);
        },
        child: Container(
          color: Colors.transparent,
          margin: EdgeInsets.symmetric(horizontal: 3),
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
