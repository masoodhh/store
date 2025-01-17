import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:store/features/home/data/models/category_model.dart';
import 'package:store/features/product/data/models/product_detailes_model.dart';
import 'package:store/features/search/presentation/manager/search/search_bloc.dart';

import '../../../../../core/params/constants.dart';
import '../../../../../core/resources/data_state.dart';
import '../../../../../logger.dart';
import '../../models/product_model.dart';

class DataProvider {
  Dio dio = Dio();

  Future<DataState<List<ProductModel>>> homeGetProductsByCategory({required int category_id}) async {
    try {
      final response = await dio.get(
        '${Constants.API_URL}/products/',
        queryParameters: {
          'page_size': 12,
          'page': 1,
          'category_id': category_id != 0 ? category_id : null,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json', // نوع محتوا
          },
        ),
      );

      if (response.statusCode == 200) {
        final products = response.data;
        final List<ProductModel> productModels = [];
        if (products["results"] != null) {
          products["results"].forEach((v) {
            productModels.add(ProductModel.fromJson(v));
          });
        }
        return DataSuccess(productModels);
      } else {
        return DataFailed(response.statusMessage);
      }
    } on DioException catch (e) {
      if (e.response != null) {
        return DataFailed(e.response!.statusMessage);
      } else {
        return DataFailed(e.message);
      }
    } catch (e) {
      logger.e(e);
      return DataFailed('Unexpected Error: $e');
    }
  }

  Future<DataState<List<CategoryModel>>> homeGetCategories() async {
    try {
      final response = await dio.get(
        '${Constants.API_URL}/categories/', // آدرس API
        options: Options(
          headers: {
            'Content-Type': 'application/json', // نوع محتوا
          },
        ),
      );

      if (response.statusCode == 200) {
        final categories = response.data;
        List<CategoryModel> categoryModels =
            categories.map<CategoryModel>((category) => CategoryModel.fromJson(category)).toList();
        return DataSuccess(categoryModels);
      } else {
        return DataFailed(response.statusMessage);
      }
    } on DioException catch (e) {
      if (e.response != null) {
        return DataFailed(e.response!.statusMessage);
      } else {
        return DataFailed(e.message);
      }
    } catch (e) {
      return DataFailed('Unexpected Error: $e');
    }
  }

  Future<DataState<List<ProductModel>>> homeGetProductsBySearch({required SearchFilter searchFilter}) async {
    try {
      var args = {};
      logger.w(searchFilter.toJson());

      final response = await dio.get(
        '${Constants.API_URL}/products/search/',
        queryParameters: searchFilter.toJson(),
        options: Options(
          headers: {
            'Content-Type': 'application/json', // نوع محتوا
          },
        ),
      );
      logger.w(response.data);

      if (response.statusCode == 200) {
        final products = response.data;
        final List<ProductModel> productModels = [];
        if (products["results"] != null) {
          products["results"].forEach((v) {
            productModels.add(ProductModel.fromJson(v));
          });
        }
        return DataSuccess(productModels);
      } else {
        return DataFailed(response.statusMessage);
      }
    } on DioException catch (e) {
      if (e.response != null) {
        return DataFailed(e.response!.statusMessage);
      } else {
        return DataFailed(e.message);
      }
    } catch (e) {
      logger.e(e);
      return DataFailed('Unexpected Error: $e');
    }
  }

  Future<DataState<ProductDetailesModel>> getProductDetiales({required int product_id}) async {
    // try {
      final response = await dio.get(
        '${Constants.API_URL}/products/$product_id', // آدرس API
        options: Options(
          headers: {
            'Content-Type': 'application/json', // نوع محتوا
          },
        ),
      );

      if (response.statusCode == 200) {

        ProductDetailesModel productDetialesModel =ProductDetailesModel.fromJson(response.data);
        return DataSuccess(productDetialesModel);
      } else {
        return DataFailed(response.statusMessage);
      }
   /* } on DioException catch (e) {
      logger.e(e);
      if (e.response != null) {
        return DataFailed(e.response!.statusMessage);
      } else {
        return DataFailed(e.message);
      }
    } catch (e) {
      logger.e(e);
      return DataFailed('Unexpected Error: $e');
    }*/
  }
}
