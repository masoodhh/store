import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:store/core/manager/cart/cart_bloc.dart';

import '../../../../core/params/colors.dart';
import '../../../../core/widgets/header.widget.dart';
import '../../../../core/widgets/spacer.widget.dart';
import '../../../home/domain/entities/cart_entity.dart';
import 'check_out_page.dart';

class CartTab extends StatefulWidget {
  const CartTab({super.key});

  @override
  State<CartTab> createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              HeaderWidget(),
              SpacerV(20),
              _buildCarts(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildTotalPrice(),
    );
  }

  Widget _buildCarts() {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state.cart.isEmpty)
          return Center(
              child: Text(
            "محصولی در سبد خرید موجود نیست.",
            textDirection: TextDirection.rtl,
            style: TextStyle(color: MyColors.primaryColor, fontSize: 20, fontWeight: FontWeight.bold),
          ));
        return SlidableAutoCloseBehavior(
          closeWhenOpened: true,
          closeWhenTapped: true,
          child: ListView(shrinkWrap: true, physics: NeverScrollableScrollPhysics(), children: [
            for (CartEntity cart in state.cart) _build_list_item(cart, context),
          ]),
        );
      },
    );
  }

  Widget _build_list_item(CartEntity cart, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      // padding: EdgeInsets.all(15),

      child: Slidable(
        closeOnScroll: true,
        groupTag: '0',
        key: ValueKey(cart.id),
        endActionPane: ActionPane(
          // A motion is a widget used to control how the pane animates.
          motion: const DrawerMotion(),

          // A pane can dismiss the Slidable.
          dismissible: DismissiblePane(onDismissed: () {
            BlocProvider.of<CartBloc>(context).add(removeProduct(cart));
          }),
          openThreshold: 0.2,
          // closeThreshold: 0.25,
          extentRatio: 0.25,

          // All actions are defined in the children parameter.
          children: [
            // A SlidableAction can have an icon and/or a label.
            SlidableAction(
              onPressed: (context) {
                BlocProvider.of<CartBloc>(context).add(removeProduct(cart));
              },
              autoClose: true,
              backgroundColor: Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
              borderRadius: BorderRadius.circular(10),
            )
          ],
        ),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          // margin: EdgeInsets.symmetric(vertical: 10),
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color:  MyColors.primaryBackgroundColor,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage(cart.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: SizedBox(
                  height: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        cart.title,
                        style: TextStyle(color: MyColors.primaryColor, fontSize: 20),
                      ),
                      RichText(
                        text: TextSpan(
                          text: "\$${cart.price}",
                          style: TextStyle(color: Colors.orange, fontSize: 18),
                          children: [
                            TextSpan(
                              text: "/Kg",
                              style: TextStyle(color: Colors.grey, fontSize: 15),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(width: 10),
              SizedBox(
                height: 100,
                child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                  GestureDetector(
                    onTap: () {
                      BlocProvider.of<CartBloc>(context).add(increamentProduct(cart));
                    },
                    child: const Icon(
                      Icons.add,
                      color: MyColors.primaryColor,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: MyColors.primaryColor,
                    ),
                    child: Text(
                      cart.count.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      BlocProvider.of<CartBloc>(context).add(decreaseProduct(cart));
                    },
                    child: const Icon(
                      Icons.remove,
                      color: MyColors.primaryColor,
                    ),
                  ),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTotalPrice() {
    return Container(
      height: 150,
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            height: 60,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color:  MyColors.primaryBackgroundColor,
            ),
            child: Center(
              child: BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  return Text(
                    "Total Price \$${state.totalPrice}",
                    style: TextStyle(color: MyColors.primaryColor, fontSize: 18, fontWeight: FontWeight.bold),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 10),
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              return InkWell(
                onTap: () {
                  if (!state.cart.isEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CheckOutPage()),
                    );
                  }
                },
                child: Container(
                  height: 60,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: MyColors.primaryColor,
                  ),
                  child: Center(
                    child: Text(
                      "CheckOut",
                      style: TextStyle(
                          color: state.cart.isEmpty ? Colors.grey : Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
