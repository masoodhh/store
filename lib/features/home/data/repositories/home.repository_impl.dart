import 'package:store/core/resources/data_state.dart';
import 'package:store/features/order/data/models/order.model.dart';
import 'package:store/features/search/presentation/manager/search/search_bloc.dart';

import '../../../../logger.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/home.repository.dart';
import '../data_sources/data_provider.dart';
import '../models/category_model.dart';
import '../models/home_products_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeRepositoryImplLocal implements HomeRepository {
  @override
  Future<DataState<List<ProductEntity>>> fetchHomeProducts({required int categoryId}) async {
    try {
      final result = await DataProvider().homeGetProductsByCategory(category_id: categoryId);
      // List  products = HomeProductsModel.fromJson(result).products!;
      return DataSuccess(HomeProductsModel.fromJson(result).products!);
    } catch (error) {
      return DataFailed("error is $error");
    }
  }

  @override
  Future<DataState<List<CategoryEntity>>> fetchHomeCategories() async {
    try {

      final result = await DataProvider().homeGetCategories();
      List<CategoryEntity> categories = List<CategoryEntity>.from(
        result["categories"].map((category) => CategoryModel.fromjson(category)).toList(),
      );

      return DataSuccess(categories);
    } catch (error) {
      return DataFailed("error is $error");
    }
  }

  @override
  Future<DataState<List<ProductEntity>>> getSearchedProducts({required SearchFilter searchFilter}) async {
    // TODO: implement getSearchedProducts
    try {
      final result = await DataProvider().homeGetProductsBySearch(searchFilter: searchFilter);
      // List  products = HomeProductsModel.fromJson(result).products!;
      return DataSuccess(HomeProductsModel.fromJson(result).products!);
    } catch (error) {
      return DataFailed("error is $error");
    }
  }

  @override
  Future<List<String>> getRecentlySearched() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList("recent_searches") ?? [];
  }

  @override
  Future<void> addRecentlySearched(String text) async {
    final prefs = await SharedPreferences.getInstance();
    final currentSearches = prefs.getStringList("recent_searches") ?? [];

    // بررسی و جلوگیری از تکراری شدن عبارت
    if (currentSearches.contains(text)) {
      currentSearches.remove(text);
    }

    // افزودن عبارت جدید به ابتدای لیست
    currentSearches.insert(0, text);

    // محدود کردن تعداد جستجوهای ذخیره‌شده (مثلاً به 10 مورد آخر)
    if (currentSearches.length > 10) {
      currentSearches.removeLast();
    }

    // ذخیره لیست به‌روزرسانی‌شده
    await prefs.setStringList("recent_searches", currentSearches);
  }
}
