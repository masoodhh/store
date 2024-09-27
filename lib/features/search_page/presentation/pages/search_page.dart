import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/core/manager/cart/cart_bloc.dart';
import 'package:store/core/params/params.dart';
import 'package:store/features/cart_page/presentation/manager/checkout/checkout_bloc.dart';
import 'package:store/features/home_page/domain/entities/produc_entity.dart';
import 'package:store/features/home_page/presentation/manager/home/home_bloc.dart';
import 'package:store/pages/food/product.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      toolbarHeight: 110,
      backgroundColor: const Color(0xFF18263E),
      title: const Text(
        "Search",
        style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      leadingWidth: 70,
      leading: Container(
        margin: const EdgeInsets.only(top: 20, bottom: 20, left: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), border: Border.all(width: 1, color: Colors.white)),
        child: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 25),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: const Color(0xFF18263E),
      child: Column(
        children: [
          _buildSeachBox(),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(child: _buildProductList()),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSeachBox() {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: Colors.white),
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
      height: 60,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                color: Colors.black45,
                size: 30,
              )),
          Expanded(
              child: TextField(
            controller: _searchController,
            style: TextStyle(color: Colors.black54, fontSize: 20),
            decoration: const InputDecoration(
              border: InputBorder.none, // حذف حاشیه TextField
            ),
          )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.filter_alt,
                color: Colors.black45,
                size: 30,
              ))
        ],
      ),
    );
  }

  Widget _buildProductList() {
    return BlocBuilder<HomeBloc, HomeState>(
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
