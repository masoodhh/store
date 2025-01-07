import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:store/features/search/presentation/manager/search/search_bloc.dart';

class DataProvider {
  Future<dynamic> getOrders() async {
    final jsonString = await rootBundle.loadString('lib/features/order/data/data_sources/orders.json');
    return jsonDecode(jsonString);
  }

  Future<dynamic> getOrdersByCategory(int categoryId) async {
    late final jsonString;
    if (categoryId == 0) {
      jsonString = await rootBundle.loadString('lib/features/order/data/data_sources/orders.json');
    } else if (categoryId == 1) {
      jsonString = await rootBundle.loadString('lib/features/order/data/data_sources/orders1.json');
    } else {
      jsonString = await rootBundle.loadString('lib/features/order/data/data_sources/orders2.json');
    }
    return jsonDecode(jsonString);
  }
}
