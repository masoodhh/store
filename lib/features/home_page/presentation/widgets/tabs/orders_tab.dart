import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/core/manager/cart/cart_bloc.dart';
import 'package:store/features/home_page/presentation/widgets/header_widget.dart';

import '../../../../../core/params/params.dart';
import '../../../domain/entities/cart_entity.dart';

class OrdersTab extends StatefulWidget {
  const OrdersTab({super.key});

  @override
  State<OrdersTab> createState() => _OrdersTabState();
}

class _OrdersTabState extends State<OrdersTab> {
  @override
  void initState() {
    super.initState();
  }

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
            _buildCategories(),
            const SizedBox(height: 20),
            _buildOrders(),
          ],
        ),
      ),
    );
  }


  Widget _buildCategories() {
    return BlocBuilder<CartBloc, CartState>(
      buildWhen: (previous, current) => previous.cart_category != current.cart_category,
      builder: (context, state) {
        return Row(
          children: [
            _buildCategoryWidget(0, "All Orders", state.cart_category == 0),
            _buildCategoryWidget(1, "Pending", state.cart_category == 1),
            _buildCategoryWidget(2, "Processing", state.cart_category == 2),
          ],
        );
        if (state.status == Status.SUCCESS) {
          return const SizedBox(height: 20);
        } else {
          return const SizedBox(height: 20);
        }
      },
    );
  }

  Widget _buildCategoryWidget(int id, String title, bool selected) {
    return Expanded(
      child: InkWell(
        onTap: () {
          BlocProvider.of<CartBloc>(context).add(changeCartCategory(id));
        },
        child: Container(
          margin: const EdgeInsets.only(right: 10),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: selected ? const Color(0xFF18263E) : Colors.grey[100],
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: selected ? Colors.white : const Color(0xFF18263E),
                fontSize: 15,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOrders() {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        return ListView(shrinkWrap: true, physics: NeverScrollableScrollPhysics(), children: [
          for (CartEntity cart in state.cart)
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
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
                          Text(
                            '12/12/2022',
                            style: TextStyle(color: Colors.grey, fontSize: 15),
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
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.grey[300],
                    ),
                    child: Center(
                      child: Text(
                        "Proccessing",
                        style: TextStyle(
                          color: const Color(0xFF18263E),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ]);
      },
    );
  }
}
