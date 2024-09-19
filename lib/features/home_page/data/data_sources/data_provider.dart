import 'dart:convert';

import 'package:flutter/services.dart';


class DataProvider {
  Future<dynamic> homeGetProductsByCategory({required int category_id}) async {
    if (category_id==0){
      final jsonString = await rootBundle.loadString(
          'lib/features/home_page/data/data_sources/home_products.json');
      return jsonDecode(jsonString);
    }else{
      final jsonString = await rootBundle.loadString(
          'lib/features/home_page/data/data_sources/home_products2.json');
      return jsonDecode(jsonString);
    }

  }
  Future<dynamic> homeGetCategories() async {
    final jsonString = await rootBundle.loadString(
        'lib/features/home_page/data/data_sources/home_categories.json');
    return jsonDecode(jsonString);
  }
}
