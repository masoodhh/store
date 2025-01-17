import 'package:store/core/resources/data_state.dart';
import 'package:store/features/home/data/models/product_model.dart';
import 'package:store/features/search/presentation/manager/search/search_bloc.dart';

import '../../../../logger.dart';
import '../../../product/domin/entities/product_detail_entity.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/home.repository.dart';
import '../models/category_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeRepositoryImpl implements HomeRepository {
  final apiProvider;

  HomeRepositoryImpl(this.apiProvider);

  @override
  Future<DataState<List<ProductEntity>>> fetchHomeProducts({required int categoryId}) async {
    final DataState<List<ProductModel>> result =
        await apiProvider.homeGetProductsByCategory(category_id: categoryId);
    if (result is DataSuccess) {
      final List<ProductEntity> products = result.data! as List<ProductEntity>;
      return DataSuccess(products);
    } else {
      return result;
    }
  }

  @override
  Future<DataState<List<CategoryEntity>>> fetchHomeCategories() async {
    final DataState<List<CategoryModel>> result = await apiProvider.homeGetCategories();
    if (result is DataSuccess) {
      final List<CategoryEntity> categories = result.data! as List<CategoryEntity>;
      return DataSuccess(categories);
    } else {
      return result;
    }
  }

  @override
  Future<DataState<List<ProductEntity>>> getSearchedProducts({required SearchFilter searchFilter}) async {
    final result = await apiProvider.homeGetProductsBySearch(searchFilter: searchFilter);
    if (result is DataSuccess) {
      final List<ProductEntity> products = result.data! as List<ProductEntity>;
      return DataSuccess(products);
    } else {
      return result;
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

  @override
  Future<DataState<ProductDetailesEntity>> getProductDetial({required int product_id}) async {
    final result = await apiProvider.getProductDetiales(product_id: product_id);
    if (result is DataSuccess) {
      final ProductDetailesEntity productDetailesEntity =result.data! as ProductDetailesEntity;
      return DataSuccess(productDetailesEntity);
    } else {
      return result;
    }
  }
}
