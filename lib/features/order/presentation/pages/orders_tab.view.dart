import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:store/features/order/presentation/manager/order/order_bloc.dart';
import 'package:store/features/order/presentation/pages/orders_details.view.dart';

import '../../../../core/params/colors.dart';
import '../../../../core/params/params.dart';
import '../../../../core/widgets/header.widget.dart';
import '../../../../core/widgets/spacer.widget.dart';
import '../../domain/entities/order.entity.dart';

class OrdersTab extends StatefulWidget {
  const OrdersTab({super.key});

  @override
  State<OrdersTab> createState() => _OrdersTabState();
}

class _OrdersTabState extends State<OrdersTab> {
  @override
  void initState() {
    BlocProvider.of<OrderBloc>(context).add(InitiaclEvent());
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
            SpacerV(20),
            _buildCategories(),
            SpacerV(20),
            _buildOrders(),
          ],
        ),
      ),
    );
  }

  Widget _buildCategories() {
    return BlocBuilder<OrderBloc, OrderState>(
      buildWhen: (previous, current) => previous.currentCategory != current.currentCategory,
      builder: (context, state) {
        return Row(
          children: [
            _buildCategoryWidget(0, "All Orders", state.currentCategory == 0),
            _buildCategoryWidget(1, "Pending", state.currentCategory == 1),
            _buildCategoryWidget(2, "Processing", state.currentCategory == 2),
          ],
        );
        if (state.status == Status.SUCCESS) {
          return SpacerV(20);
        } else {
          return SpacerV(20);
        }
      },
    );
  }

  Widget _buildCategoryWidget(int id, String title, bool selected) {
    return Expanded(
      child: InkWell(
        onTap: () {
          BlocProvider.of<OrderBloc>(context).add(ChangeCurrentCategoryEvent(categoryId: id));
        },
        child: Container(
          margin: const EdgeInsets.only(right: 10),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: selected ? MyColors.primaryColor : MyColors.primaryBackgroundColor,
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: selected ? Colors.white : MyColors.primaryColor,
                fontSize: 15,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOrders() {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        return ListView(shrinkWrap: true, physics: NeverScrollableScrollPhysics(), children: [
          for (OrderEntity order in state.orders)
            InkWell(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderDetailsPage(
                      orderEntity: order,
                    ),
                  )),
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: MyColors.primaryBackgroundColor,
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
                          image: AssetImage(order.image),
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
                              order.title,
                              style: TextStyle(color: MyColors.primaryColor, fontSize: 20),
                            ),
                            Text(
                              DateFormat('yyyy/MM/dd').format(order.orderStatuses
                                  .lastWhere(
                                    (element) => element.status,
                                  )
                                  .dateTime!),
                              style: TextStyle(color: Colors.grey, fontSize: 15),
                            ),
                            RichText(
                              text: TextSpan(
                                text: "\$${order.totalPrice}",
                                style: TextStyle(color: Colors.orange, fontSize: 18),
                                children: const [
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
                          order.orderStatuses
                              .lastWhere(
                                (element) => element.status,
                              )
                              .title,
                          style: TextStyle(
                            color: MyColors.primaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ]);
      },
    );
  }
}
