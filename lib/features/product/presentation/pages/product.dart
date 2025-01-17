import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' as intl;
import 'package:store/core/manager/cart/cart_bloc.dart';
import 'package:store/core/params/text_styles.dart';
import 'package:store/features/product/presentation/manager/product/product_cubit.dart';

import '../../../../core/params/colors.dart';
import '../../../../core/params/constants.dart';
import '../../../../core/params/params.dart';
import '../../../home/domain/entities/product_entity.dart';
import '../../domin/entities/review_entity.dart';

class Product extends StatefulWidget {
  final ProductEntity product;

  const Product({required this.product, super.key});

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  @override
  void initState() {
    BlocProvider.of<ProductCubit>(context).initializeEvent(widget.product.id);
    super.initState();
  }

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
                  // Product description
                  _buildProductDescription(),
                  // Similar products
                  _buildSimilarProducts(),
                  // Product reviews
                  _buildProductReviews(),
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
            child: Constants.DATA_SOURCE == 0
                ? Image.asset(
              widget.product.image,
              fit: BoxFit.contain,
              width: double.infinity,
              height: 300,
            )
                : Image.network(
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
          style: const TextStyle(fontSize: 30, color: MyColors.primaryColor, fontWeight: FontWeight.bold),
          textDirection: getTextDirection(widget.product.title),
        ),
/*
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
*/
      ],
    );
  }

  Widget _buildProductDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Product Description",
          style: TextStyle(fontSize: 30, color: MyColors.primaryColor, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          width: double.infinity,
          child: Text(
            widget.product.description,
            style: MyTextStyles.caption,
            textDirection: getTextDirection(widget.product.description),
          ),
        ),
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
        BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            if (state.status == Status.SUCCESS && state.reviews != null) {
              return SizedBox(
                width: double.infinity,
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.reviews!.length,
                    itemBuilder: (context, index) {
                      final ReviewEntity review = state.reviews![index];
                      return Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: MyColors.primaryBackgroundColor,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                          image: review.userImage == null
                                              ? null
                                              : DecorationImage(
                                              image: NetworkImage(review.userImage!), fit: BoxFit.cover),
                                          shape: BoxShape.circle,
                                          color: Colors.grey),
                                    ),
                                    const SizedBox(width: 10),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          review.userName,
                                          style: const TextStyle(
                                              color: MyColors.primaryColor,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        ratingStarWidget(review.rating)
                                      ],
                                    )
                                  ],
                                ),
                                Text(intl.DateFormat('d MMMM y').format(review.date),
                                    style: const TextStyle(color: Colors.grey, fontSize: 16))
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: Text(
                                review.comment,
                                textDirection: getTextDirection(review.comment),
                                style: const TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              );
            } else {
              return Container();
            }
          },
        ),
      ],
    );
  }

  Row ratingStarWidget(double value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(5, (index) {
        // اگر index کمتر از value باشد، ستاره پر نمایش داده می‌شود
        if (index < value) {
          if (value - index < 1) {
            return const Icon(Icons.star_half, color: Colors.amber, size: 25);
          } else {
            return const Icon(Icons.star, color: Colors.amber, size: 25);
          }
        } else {
          // در غیر این صورت، ستاره خالی نمایش داده می‌شود
          return const Icon(Icons.star_border, color: Colors.amber, size: 25);
        }
      }),
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
        SizedBox(
          height: 10,
        ),
        BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            if (state.status == Status.SUCCESS && state.similarProducts != null) {
              return SizedBox(
                height: 170,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.similarProducts!.length,
                  itemBuilder: (context, index) {
                    return _buildProductWidget(state.similarProducts![index]);
                  },
                ),
              );
            } else {
              return Container();
            }
          },
        ),
        SizedBox(
          height: 20,
        )
        // Add similar products here
      ],
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      height: 70,
      color: MyColors.primaryColor,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RichText(
              text: TextSpan(
                text: "\$${widget.product.price}",
                style: const TextStyle(color: Colors.white, fontSize: 20),
                children: const [
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
                        color: state.cart.any((p) => p.id == widget.product.id) ? Colors.grey : Colors.white),
                    padding: const EdgeInsets.all(10),
                    height: 40,
                    alignment: Alignment.center,
                    width: 200,
                    child: Text(
                      state.cart.any((p) => p.id == widget.product.id) ? 'Remove from cart' : 'Add to cart',
                      style: const TextStyle(
                          color: MyColors.primaryColor, fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _buildProductWidget(ProductEntity product) {
    return GestureDetector(
      onTap: () =>
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => Product(product: product))),
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        // margin: EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: MyColors.primaryBackgroundColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: Constants.DATA_SOURCE == 0 ? AssetImage(product.image) : NetworkImage(product.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              product.title,
              style: const TextStyle(color: MyColors.primaryColor, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }

  TextDirection getTextDirection(String text) {
    final rtlRegex = RegExp(r'[\u0600-\u06FF\u0750-\u077F\u08A0-\u08FF\uFB50-\uFDFF\uFE70-\uFEFF]');
    return rtlRegex.hasMatch(text) ? TextDirection.rtl : TextDirection.ltr;
  }
}
