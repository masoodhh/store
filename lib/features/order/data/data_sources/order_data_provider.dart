import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:store/features/search/presentation/manager/search/search_bloc.dart';

import '../../../../core/resources/data_state.dart';
import '../models/order.model.dart';

class OrderDataProviderLocal {
  Future<DataState<bool>> addOrder(OrderModel order) async {
    //TODO
    return DataSuccess(true);
  }

  Future<DataState<List<OrderModel>>> getOrders() async {
    final jsonString = await rootBundle.loadString('lib/features/order/data/data_sources/orders.json');
    final orders = jsonDecode(jsonString);
    List<OrderModel> orderModel =
        orders.map<OrderModel>((category) => OrderModel.fromJson(category)).toList();
    return DataSuccess(orderModel);
  }

  Future<DataState<OrderModel>> getOrderById(int orderId) async {
    final jsonString = await rootBundle.loadString('lib/features/order/data/data_sources/order.json');
    OrderModel order = OrderModel.fromJson(jsonDecode(jsonString));
    return DataSuccess(order);
  }

  Future<DataState<List<OrderModel>>> getOrdersByStage(int stageNumber) async {
    late final jsonString;
    if (stageNumber == 0) {
      jsonString = await rootBundle.loadString('lib/features/order/data/data_sources/orders.json');
    } else if (stageNumber == 2) {
      jsonString = await rootBundle.loadString('lib/features/order/data/data_sources/orders1.json');
    } else {
      jsonString = await rootBundle.loadString('lib/features/order/data/data_sources/orders2.json');
    }
    final orders = jsonDecode(jsonString);
    List<OrderModel> orderModel =
        orders.map<OrderModel>((category) => OrderModel.fromJson(category)).toList();
    return DataSuccess(orderModel);
  }
}
