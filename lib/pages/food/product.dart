import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/features/home_page/domain/entities/product_entity.dart';
import 'package:store/core/manager/cart/cart_bloc.dart';

import '../../core/params/colors.dart';

class Product extends StatefulWidget {
  final ProductEntity product;

  const Product({required this.product, super.key});

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<CartBloc>(),
      child: Scaffold(
        body: Container(
          width: double.infinity,
          color: MyColors.primaryColor,
          child: Container(
            height: double.infinity,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)), color: Colors.white),
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product image and back button
                  _buildProductImageAndBackButton(),
                  // Product title and quantity
                  _buildProductTitleAndQuantity(),
                  // Product administered in
                  _buildProductAdministeredIn(),
                  // Product description
                  _buildProductDescription(),
                  // Product reviews
                  _buildProductReviews(),
                  // Similar products
                  _buildSimilarProducts(),
                ],
              ),
            ),
          ),
        ),
        // Bottom navigation bar
        bottomNavigationBar: _buildBottomNavigationBar(),
      ),
    );
  }

  // * Widgets
  Widget _buildProductImageAndBackButton() {
    return Stack(
      children: [
        Hero(
            tag: "product${widget.product.id}",
            child: Image.asset(
              widget.product.image,
              fit: BoxFit.contain,
              width: double.infinity,
              height: 300,
            )),
        Positioned(
          top: 10,
          left: 10,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 1, color: Colors.black12)),
              padding: const EdgeInsets.all(10),
              height: 60,
              child: const Icon(
                Icons.arrow_back,
                color: MyColors.primaryColor,
                size: 30,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildProductTitleAndQuantity() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.product.title,
          style: TextStyle(fontSize: 30, color: MyColors.primaryColor, fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(shape: BoxShape.circle, color: MyColors.primaryColor),
                child: const Icon(
                  Icons.remove,
                  color: Colors.white,
                )),
            const SizedBox(width: 10),
            const Text("1Kg",
                style: TextStyle(fontWeight: FontWeight.bold, color: MyColors.primaryColor, fontSize: 20)),
            const SizedBox(width: 10),
            Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(shape: BoxShape.circle, color: MyColors.primaryColor),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ))
          ],
        )
      ],
    );
  }

  Widget _buildProductAdministeredIn() {
    return const Text("Administered in china", style: TextStyle(color: Colors.grey));
  }

  Widget _buildProductDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Product Description",
          style: TextStyle(fontSize: 30, color: MyColors.primaryColor, fontWeight: FontWeight.bold),
        ),
        Text(widget.product.description, style: TextStyle(color: Colors.grey)),
      ],
    );
  }

  Widget _buildProductReviews() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Product Reviews",
          style: TextStyle(fontSize: 30, color: MyColors.primaryColor, fontWeight: FontWeight.bold),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage('https://picsum.photos/102'), fit: BoxFit.cover),
                      shape: BoxShape.circle,
                      color: Colors.blue),
                ),
                const SizedBox(width: 10),
                const Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Victor Hogon",
                      style:
                          TextStyle(color: MyColors.primaryColor, fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 25),
                        Icon(Icons.star, color: Colors.amber, size: 25),
                        Icon(Icons.star, color: Colors.amber, size: 25),
                        Icon(Icons.star, color: Colors.amber, size: 25),
                        Icon(Icons.star, color: Colors.amber, size: 25),
                      ],
                    )
                  ],
                )
              ],
            ),
            const Text("16 september 2022", style: TextStyle(color: Colors.grey, fontSize: 16))
          ],
        ),
        const SizedBox(height: 10),
        const Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed vel urna at nunc bibendum pulvinar.',
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildSimilarProducts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Similar Products",
          style: TextStyle(fontSize: 30, color: MyColors.primaryColor, fontWeight: FontWeight.bold),
        ),
        // Add similar products here
      ],
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      height: 70,
      color: MyColors.primaryColor,
      child: Container(
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RichText(
                text: TextSpan(
                  text: "\$${widget.product.price}",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                  children: [
                    TextSpan(
                      text: "/Kg",
                      style: TextStyle(color: Colors.grey, fontSize: 18),
                    ),
                  ],
                ),
              ),
              BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  return GestureDetector(
                    onTap: () {
                      state.cart.any((p) => p.id == widget.product.id)
                          ? BlocProvider.of<CartBloc>(context).add(removeProduct(widget.product))
                          : BlocProvider.of<CartBloc>(context).add(addProduct(widget.product));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color:
                              state.cart.any((p) => p.id == widget.product.id) ? Colors.grey : Colors.white),
                      padding: const EdgeInsets.all(10),
                      height: 40,
                      alignment: Alignment.center,
                      width: 200,
                      child: Text(
                        state.cart.any((p) => p.id == widget.product.id) ? 'Remove from cart' : 'Add to cart',
                        style: TextStyle(
                            color: MyColors.primaryColor, fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
