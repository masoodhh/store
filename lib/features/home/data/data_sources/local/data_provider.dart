import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:store/features/home/data/models/category_model.dart';
import 'package:store/features/search/presentation/manager/search/search_bloc.dart';

import '../../../../../core/resources/data_state.dart';
import '../../../../../logger.dart';
import '../../models/product_model.dart';

class DataProvider {
  Future<dynamic> homeGetProductsByCategory({required int category_id}) async {
    if (category_id == 0) {
      final jsonString =
          await rootBundle.loadString('lib/features/home/data/data_sources/local/home_products.json');
      final products = jsonDecode(jsonString);
      final List<ProductModel> productModels = [];
      if (products["results"] != null) {
        products["results"].forEach((v) {
          productModels.add(ProductModel.fromJson(v));
        });
      }
      return DataSuccess(productModels);
    } else {
      final jsonString =
          await rootBundle.loadString('lib/features/home/data/data_sources/local/home_products2.json');
      final products = jsonDecode(jsonString);
      final List<ProductModel> productModels = [];
      if (products["results"] != null) {
        products["results"].forEach((v) {
          productModels.add(ProductModel.fromJson(v));
        });
      }
      return DataSuccess(productModels);
    }
  }

  Future<DataState<List<CategoryModel>>> homeGetCategories() async {
    final jsonString =
        await rootBundle.loadString('lib/features/home/data/data_sources/local/home_categories.json');
    final categories = jsonDecode(jsonString);
    List<CategoryModel> categoryModels =
        categories.map<CategoryModel>((category) => CategoryModel.fromJson(category)).toList();
    return DataSuccess(categoryModels);
  }

  homeGetProductsBySearch({required SearchFilter searchFilter}) async {
    if (searchFilter.categoryId == 0) {
      final jsonString =
          await rootBundle.loadString('lib/features/home/data/data_sources/local/home_products.json');
      final products = jsonDecode(jsonString);
      final List<ProductModel> productModels = [];
      if (products["results"] != null) {
        products["results"].forEach((v) {
          productModels.add(ProductModel.fromJson(v));
        });
      }
      return DataSuccess(productModels);
    } else {
      final jsonString =
          await rootBundle.loadString('lib/features/home/data/data_sources/local/home_products2.json');
      final products = jsonDecode(jsonString);
      final List<ProductModel> productModels = [];
      if (products["results"] != null) {
        products["results"].forEach((v) {
          productModels.add(ProductModel.fromJson(v));
        });
      }
      return DataSuccess(productModels);
    }
  }
}
