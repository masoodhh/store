import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/features/home_page/domain/entities/produc_entity.dart';
import 'package:store/features/home_page/presentation/manager/cart/cart_bloc.dart';
import 'package:store/features/home_page/presentation/manager/home/home_bloc.dart';
import 'package:store/features/home_page/presentation/widgets/header_widget.dart';
import 'package:store/pages/food/product.dart';

import 'package:store/core/params/params.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<CartBloc, CartState>(
      listener: (context, state) {
        if (state.message != null) {
          if (state.message is SuccessMessage) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
                showCloseIcon: true,
                content: Text(state.message!.message),
              ),
            );
          } else if (state.message is ErrorMessage) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
                showCloseIcon: true,

                content: Text(state.message!.message),
              ),
            );
          }
        }
      },
      child: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              HeaderWidget(),
              const SizedBox(height: 20),
              _buildCategories(),
              _buildPopularFruits(),
              _buildProductList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategories() {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) => previous.categoryState.status != current.categoryState.status,
      builder: (context, state) {
        if (state.categoryState.status == Status.SUCCESS) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (int i = 0; i < state.categoryState.categories.length; i++)
                  _buildCategoryWidget(state.categoryState.categories[i].id,
                      state.categoryState.categories[i].title, state.categoryState.categories[i].isChecked),
              ],
            ),
          );
        } else {
          return const SizedBox(height: 20);
        }
      },
    );
  }

  Widget _buildCategoryWidget(int id, String title, bool selected) {
    return InkWell(
      onTap: () {
        context.read<HomeBloc>().add(ChangeCategoryEvent(id));
      },
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: selected ? const Color(0xFF18263E) : Colors.grey[100],
        ),
        child: Text(
          title,
          style: TextStyle(
            color: selected ? Colors.white : const Color(0xFF18263E),
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  Widget _buildPopularFruits() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Popular Fruits",
              style: TextStyle(
                color: Color(0xFF18263E),
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const Text(
              "See All",
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildProductList() {
    return SizedBox(
      width: double.infinity,
      child: BlocBuilder<HomeBloc, HomeState>(
        buildWhen: (previous, current) => previous.productState.status != current.productState.status,
        builder: (context, state) {
          if (state.productState.status == Status.SUCCESS) {
            return Wrap(
              direction: Axis.horizontal,
              alignment: WrapAlignment.spaceBetween,
              runAlignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              runSpacing: 15,
              children: [
                for (ProductEntity product in state.productState.products) _buildProductWidget(product),
              ],
            );
          } else {
            return SizedBox(height: 500);
          }
        },
      ),
    );
  }

  Widget _buildProductWidget(ProductEntity product) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Product(product: product)),
        );
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
                product.image,
                height: 150,
                fit: BoxFit.contain,
              ),
            ),
            Text(
              product.title,
              style: const TextStyle(
                fontSize: 20,
                color: Color(0xFF18263E),
                fontWeight: FontWeight.bold,
              ),
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
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () => BlocProvider.of<CartBloc>(context).add(addProduct(product)),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: Colors.orange,
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
