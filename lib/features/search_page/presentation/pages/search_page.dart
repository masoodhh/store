import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/core/manager/cart/cart_bloc.dart';
import 'package:store/core/params/params.dart';
import 'package:store/features/cart_page/presentation/manager/checkout/checkout_bloc.dart';
import 'package:store/features/home_page/domain/entities/product_entity.dart';
import 'package:store/features/home_page/presentation/manager/home/home_bloc.dart';
import 'package:store/pages/food/product.dart';

import '../../../../core/params/colors.dart';

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
      // appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      height: 110,
      child: Stack(
        children: [
          const Center(
              child: Text(
            "Search",
            style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
          )),
          Positioned(
              left: 0,
              child: Container(
                width: 50,
                height: 70,
                margin: const EdgeInsets.only(top: 20, bottom: 20, left: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 1, color: Colors.white)),
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back, color: Colors.white, size: 25),
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color:  MyColors.primaryColor,
      child: Column(
        children: [
          _buildAppBar(context),
          _buildSearchBox(),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
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

  Widget _buildSearchBox() {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: Colors.white),
      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                color: Colors.black45,
                size: 30,
              )),
          Expanded(
              child: TextField(
            controller: _searchController,
            style: const TextStyle(color: Colors.black54, fontSize: 20),
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
          )),
          IconButton(
              onPressed: () {
                searchFilter(context);
              },
              icon: const Icon(
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
          return const SizedBox(height: 500);
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
          color:  MyColors.primaryBackgroundColor,
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
                color: MyColors.primaryColor,
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

  void searchFilter(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      // isDismissible: false, // غیرفعال کردن بسته شدن دیالوگ با کلیک خارج از آن
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)), // گوشه‌های گرد در بالای دیالوگ
      ),
      builder: (BuildContext context) {
        final TextEditingController _paymenttitleController = TextEditingController();
        final TextEditingController _paymentCvvController = TextEditingController();
        final TextEditingController _paymentCardNumberController = TextEditingController();
        final TextEditingController _paymentDateController = TextEditingController();
        return Container(
          height: 650, // ارتفاع دیالوگ
          padding: const EdgeInsets.all(16), // فاصله داخلی
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Filter",
                    style: TextStyle(color: MyColors.primaryColor, fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      shape: BoxShape.circle, // شکل دایره
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.update),
                      onPressed: () {
                        Navigator.pop(context); // بستن دیالوگ
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                "Price Range",
                style: TextStyle(color: MyColors.primaryColor, fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const Text(
                "Categories",
                style: TextStyle(color: MyColors.primaryColor, fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _buildCategories(),
              const SizedBox(height: 20),
              const Text(
                "Recently Search",
                style: TextStyle(color: MyColors.primaryColor, fontSize: 20, fontWeight: FontWeight.bold),
              ),
              _buildRecentlySearch(),
              Expanded(child: Container()),
              InkWell(
                onTap: () {
                  BlocProvider.of<CheckoutBloc>(context).add(addPaymentCardEvent(
                      title: _paymenttitleController.text,
                      card_number: _paymentCardNumberController.text,
                      date: _paymentDateController.text,
                      CVV: int.parse(_paymentCvvController.text),
                      icon: Icons.payment));
                  Navigator.pop(context);
                },
                child: Container(
                  height: 60,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color:  MyColors.primaryColor,
                  ),
                  child: const Center(
                    child: Text(
                      "Add New Card",
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
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
          color: selected ?  MyColors.primaryColor :  MyColors.primaryBackgroundColor,
        ),
        child: Text(
          title,
          style: TextStyle(
            color: selected ? Colors.white :  MyColors.primaryColor,
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  Widget _buildRecentlySearch() {
    return Wrap(
      runSpacing: 10,
      children: [
        _buildCategoryWidget(1, "title", true),
        _buildCategoryWidget(2, "Big title2", false),
        _buildCategoryWidget(1, "title3", false),
        _buildCategoryWidget(1, "title4", false),
        _buildCategoryWidget(1, "title5", false),
        _buildCategoryWidget(1, "title6", false),
      ],
    );
  }
}
