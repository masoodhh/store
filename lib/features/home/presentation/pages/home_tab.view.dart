import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/core/manager/cart/cart_bloc.dart';
import 'package:store/features/product/presentation/pages/product.dart';

import 'package:store/core/params/params.dart';

import '../../../../core/params/colors.dart';
import '../../../../core/params/constants.dart';
import '../../../../core/widgets/header.widget.dart';
import '../../../../core/widgets/spacer.widget.dart';
import '../../domain/entities/product_entity.dart';
import '../manager/home/home_bloc.dart';

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
      child: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SpacerV(30),
              const HeaderWidget(),
              SpacerV(20),
              _buildCategories(),
              SpacerV(20),
              _buildPopular(),
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
          return SpacerV(20);
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
          color: selected ? MyColors.primaryColor : MyColors.primaryBackgroundColor,
        ),
        child: Text(
          title,
          style: TextStyle(
            color: selected ? Colors.white : MyColors.primaryColor,
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  Widget _buildPopular() {
    return Column(
      children: [_buildPopularHeaderRow(), SpacerV(20), _buildPopularProductList()],
    );
  }

  Widget _buildPopularHeaderRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Popular Fruits",
          style: TextStyle(
            color: MyColors.primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        Text(
          "See All",
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildPopularProductList() {
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
            return SpacerV(500);
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
          color: MyColors.primaryBackgroundColor,
        ),
        padding: const EdgeInsets.all(15),
        width: MediaQuery.of(context).size.width / 2 - 15,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: "product${product.id}",
              child: Constants.DATA_SOURCE == 0
                  ? Image.asset(
                      product.image,
                      height: 150,
                      fit: BoxFit.contain,
                    )
                  : Image.network(
                      product.image,
                      height: 150,
                      fit: BoxFit.contain,
                    ),
            ),
            Text(
              product.title,
              style: const TextStyle(
                fontSize: 20,
                color: MyColors.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            SpacerV(5),
            Text(
              "${product.price} Cal",
              style: const TextStyle(fontSize: 15, color: Colors.grey),
            ),
            SpacerV(5),
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
