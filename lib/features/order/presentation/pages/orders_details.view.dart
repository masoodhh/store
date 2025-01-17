import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:store/core/params/text_styles.dart';
import 'package:store/features/home/domain/entities/product_entity.dart';
import 'package:store/features/order/domain/entities/order.entity.dart';

import '../../../../core/params/colors.dart';
import '../../../../core/params/constants.dart';

class OrderDetailsPage extends StatefulWidget {
  const OrderDetailsPage({required this.orderEntity, super.key});

  static const routeName = '/order_details';
  final OrderEntity orderEntity;

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: dispose controllers
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context, widget.orderEntity),
      bottomNavigationBar: _buildLocationMap(),
    );
  }
}

AppBar _buildAppBar(BuildContext context) {
  return AppBar(
    toolbarHeight: 110,
    backgroundColor: MyColors.primaryColor,
    title: const Text(
      "Order details",
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

Widget _buildBody(BuildContext context, OrderEntity orderEntity) {
  return Container(
    width: double.infinity,
    height: double.infinity,
    color: MyColors.primaryColor,
    child: Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        color: MyColors.primaryBackgroundColor,
      ),
      padding: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildDetails(orderEntity.orderStages),
            SizedBox(
              height: 20,
            ),
            _buildProducts(orderEntity.products),
          ],
        ),
      ),
    ),
  );
}

Widget _buildDetails(List<OrderStages> orderStatuses) {
  return Container(
    padding: const EdgeInsets.all(20),
    width: double.infinity,
    decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(30)), color: Colors.white),
    child: Column(
      children: [
        for (int i = 0; i < orderStatuses.length; i++)
          _buildDetailsItem(orderStatuses[i].dateTime, orderStatuses[i].status, orderStatuses[i].title,
              orderStatuses[i].description),

        /*_buildDetailsItem("9:30 AM", true, "Order Placed", "your order has been placed successfully"),
        _buildDetailsItem(
            "9:35 AM", true, "Confirmed", "your order is being prepared to be processed and processed"),
        _buildDetailsItem("", false, "Processing",
            "your order is being prepared to be processed and order is being prepared to be processed and processed order  is being prepared to be processed and processed"),
        _buildDetailsItem(
            "", false, "Confirmed", "your order is being prepared to be processed and processed"),
     */
      ],
    ),
  );
}

Widget _buildDetailsItem(DateTime? time, bool isPassed, String title, String description) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
        width: 120,
        child: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: time != null
              ? Column(
                  children: [
                    if(DateFormat('yyyy/MM/DD').format(time!)!=DateFormat('yyyy/MM/DD').format(DateTime.now()))
                    Text(
                      DateFormat('yyyy/MM/DD').format(time!),
                      style: MyTextStyles.header3,
                    ),
                    Text(
                      DateFormat('hh:mm a').format(time!),
                      style: MyTextStyles.header3,
                    ),
                  ],
                )
              : Container(),
        ),
      ),
      SizedBox(
        width: 40,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: MyColors.primaryColor,
                  border: Border.all(width: 2, color: MyColors.primaryColor)),
              child: isPassed
                  ? Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 25,
                    )
                  : Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      )),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              width: 1,
              height: 80,
              color: MyColors.primaryColor,
            )
          ],
        ),
      ),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.only(top: 4, left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: MyTextStyles.header2,
              ),
              Text(
                description,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                style: MyTextStyles.headline,
              ),
            ],
          ),
        ),
      )
    ],
  );
}

Widget _buildProducts(List<ProductEntity> products) {
  return Container(
    padding: const EdgeInsets.all(20),
    width: double.infinity,
    decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(30)), color: Colors.white),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Products",
          style: MyTextStyles.header,
        ),
        for (int i = 0; i < products.length; i++) _buildProductItem(products[i]),
      ],
    ),
  );
}

_buildProductItem(ProductEntity product) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 10),
    // margin: EdgeInsets.symmetric(vertical: 10),
    padding: EdgeInsets.all(15),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
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
              image: Constants.DATA_SOURCE==0?AssetImage(product.image):NetworkImage(product.image),
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
                  product.title,
                  style: TextStyle(color: MyColors.primaryColor, fontSize: 20),
                ),
                Text(
                  "total price: \$${product.price * product.count}",
                  style: TextStyle(color: Colors.orange, fontSize: 18),
                )
              ],
            ),
          ),
        ),
        SizedBox(width: 10),
        SizedBox(
          height: 100,
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: MyColors.primaryColor,
              ),
              child: Text(
                product.count.toString(),
                style: TextStyle(color: Colors.white),
              ),
            ),
          ]),
        )
      ],
    ),
  );
}

Widget _buildLocationMap() {
  return Container(
    padding: const EdgeInsets.all(10),
    child: Container(
      height: 60,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: MyColors.primaryColor,
      ),
      child: const Center(
        child: Text(
          "Location Map",
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );
}
