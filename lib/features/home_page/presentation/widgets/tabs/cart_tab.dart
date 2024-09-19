import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:store/features/home_page/presentation/manager/cart/cart_bloc.dart';
import 'package:store/features/home_page/presentation/widgets/header_widget.dart';

import '../../../domain/entities/cart_entity.dart';

class CartTab extends StatefulWidget {
  const CartTab({super.key});

  @override
  State<CartTab> createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            HeaderWidget(),
            const SizedBox(height: 20),
            _buildCarts(),
          ],
        ),
      ),
    );
  }

  Widget _buildCarts() {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        return ListView(shrinkWrap: true, physics: NeverScrollableScrollPhysics(), children: [
          for (CartEntity cart in state.cart) _build_list_item(cart, context),
        ]);
      },
    );
  }

  Widget _build_list_item(CartEntity cart, BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      // padding: EdgeInsets.all(15),

      child: Slidable(
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
            ),
          ],
        ),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          // margin: EdgeInsets.symmetric(vertical: 10),
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[100],
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
                        style: TextStyle(color: const Color(0xFF18263E), fontSize: 20),
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
                      color: const Color(0xFF18263E),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xFF18263E),
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
                      color: const Color(0xFF18263E),
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
}
