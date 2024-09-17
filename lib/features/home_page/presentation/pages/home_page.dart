import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/features/home_page/domain/entities/produc_entity.dart';
import 'package:store/features/home_page/presentation/manager/cart/cart_cubit.dart';
import 'package:store/features/home_page/presentation/manager/home/home_bloc.dart';
import 'package:store/pages/food/product.dart';

import '../../../../core/params/params.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<HomeBloc>(context).add(InitializeEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: const Color(0xFF18263E),
        child: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)), color: Colors.white),
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Daily \nGrocery Food",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xff1e1f22),
                        fontSize: 40,
                      ),
                      softWrap: true,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(width: 1, color: Colors.black12)),
                      padding: const EdgeInsets.all(10),
                      height: 80,
                      child: const Icon(
                        Icons.search,
                        color: Color(0xFF18263E),
                        size: 40,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: BlocBuilder<HomeBloc, HomeState>(
                    buildWhen: (previous, current) {
                      if (previous.categoryState.status != current.categoryState.status) {
                        return true;
                      } else {
                        return false;
                      }
                    },
                    builder: (context, state) {
                      if (state.categoryState.status == Status.SUCCESS) {
                        return Row(
                          children: [
                            for (int i = 0; i < state.categoryState.categories.length; i++)
                              CategoryWidget(
                                  state.categoryState.categories[i].id,
                                  state.categoryState.categories[i].title,
                                  state.categoryState.categories[i].isChecked)
                          ],
                        );
                      } else {
                        return const SizedBox(height: 20);
                      }
                    },
                  ),
                ),
                const SizedBox(height: 20),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Popular Fruits",
                      style: TextStyle(color: Color(0xFF18263E), fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text(
                      "See All",
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: BlocBuilder<HomeBloc, HomeState>(
                    buildWhen: (previous, current) {
                      if (previous.productState.status != current.productState.status) {
                        return true;
                      } else {
                        return false;
                      }
                    },
                    builder: (context, state) {
                      if (state.productState.status == Status.SUCCESS) {
                        return Wrap(
                          direction: Axis.horizontal,
                          alignment: WrapAlignment.spaceBetween,
                          runAlignment: WrapAlignment.spaceBetween,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          runSpacing: 15,
                          children: [
                            for (ProductEntity product in state.productState.products)
                              InkWell(
                                onTap: () {
                                  // BlocProvider.value(value: BlocProvider.of<CartCubit>(context),child:Product(product: product) ,)
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => Product(product: product)));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.grey[100],
                                  ),
                                  padding: const EdgeInsets.all(15),
                                  width: MediaQuery.of(context).size.width / 2 - 15,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Hero(
                                          tag: "product${product.id}",
                                          child: Image.asset(
                                            height: 150,
                                            product.image,
                                            fit: BoxFit.contain,
                                          )),
                                      Text(
                                        product.title,
                                        style: const TextStyle(
                                            fontSize: 20,
                                            color: Color(0xFF18263E),
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        "${product.price} Cal",
                                        style: const TextStyle(fontSize: 15, color: Colors.grey),
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "&${product.price}",
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: Colors.orange,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(2),
                                                color: Colors.orange,
                                              ),
                                              child: const Icon(
                                                Icons.add,
                                                color: Colors.white,
                                                size: 25,
                                              ))
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                          ],
                        );
                      } else {
                        return SizedBox(height: 500);
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
          height: 70,
          color: const Color(0xFF18263E),
          child: Container(
              child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buttomNavItem(true, Icons.home, "home"),
                buttomNavItem(false, Icons.shop, "shop"),
                buttomNavItem(false, Icons.person, "profile"),
                buttomNavItem(false, Icons.gif_box, "gift"),
              ],
            ),
          ))),
    );
  }

  Widget buttomNavItem(bool selected, IconData icon, String title) {
    return Container(
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
    );
  }

  Widget CategoryWidget(int id, String title, bool selected) {
    return InkWell(
      onTap: () {
        context.read<HomeBloc>().add(ChangeCategoryEvent(id));
      },
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: selected ? const Color(0xFF18263E) : Colors.grey[100]),
        child: Text(
          title,
          style: TextStyle(color: selected ? Colors.white : const Color(0xFF18263E), fontSize: 15),
        ),
      ),
    );
  }
}
