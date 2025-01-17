import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:store/features/order/data/models/order.model.dart';
import 'package:store/features/order/domain/entities/order.entity.dart';

import '../../../../../core/params/constants.dart';
import '../../../../../core/resources/data_state.dart';
import '../../../../../logger.dart';
import '../../../../product/data/models/product_detailes_model.dart';

class OrderDataProviderRemote {
  Dio dio = Dio();

  Future<DataState<bool>> addOrder(OrderModel order) async {
    try {
      final response = await dio.post(
        '${Constants.API_URL}/orders/',
        data: order.toJson(),
        options: Options(
          headers: {
            'Content-Type': 'application/json', // نوع محتوا
          },
        ),
      );
      if (response.statusCode == 200) {
        logger.w(response.data);
        OrderModel order = OrderModel.fromJson(response.data);
        return DataSuccess(true);
      } else {
        return DataFailed(response.statusMessage);
      }
    } on DioException catch (e) {
      logger.e(e);
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

  Future<DataState<List<OrderModel>>> getOrders() async {
    try {
      final response = await dio.get(
        '${Constants.API_URL}/orders/',
        data: {"user_id": 1},
        options: Options(
          headers: {
            'Content-Type': 'application/json', // نوع محتوا
          },
        ),
      );

      if (response.statusCode == 200) {
        final orders = response.data;
        List<OrderModel> orderModel =
            orders.map<OrderModel>((category) => OrderModel.fromJson(category)).toList();
        return DataSuccess(orderModel);
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

  Future<DataState<List<OrderModel>>> getOrdersByStage(int stageNumber) async {
    try {
      final response = await dio.get(
        '${Constants.API_URL}/orders/',
        queryParameters: {"stageNumber": stageNumber},
        data: {"user_id": 1},
        options: Options(
          headers: {
            'Content-Type': 'application/json', // نوع محتوا
          },
        ),
      );

      if (response.statusCode == 200) {
        final orders = response.data;
        List<OrderModel> orderModel =
            orders.map<OrderModel>((category) => OrderModel.fromJson(category)).toList();
        return DataSuccess(orderModel);
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

  Future<DataState<OrderModel>> getOrderById(int orderId) async {
    try {
      final response = await dio.get(
        '${Constants.API_URL}/oders/$orderId',
        data: {"user_id": 1},
        options: Options(
          headers: {
            'Content-Type': 'application/json', // نوع محتوا
          },
        ),
      );
      if (response.statusCode == 200) {
        OrderModel order = OrderModel.fromJson(response.data);
        return DataSuccess(order);
      } else {
        return DataFailed(response.statusMessage);
      }
    } on DioException catch (e) {
      logger.e(e);
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
}
