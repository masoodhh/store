import 'package:store/core/resources/data_state.dart';
import 'package:store/features/home_page/data/data_sources/data_provider.dart';
import 'package:store/features/home_page/data/models/category_model.dart';
import 'package:store/features/home_page/data/models/home_products_model.dart';
import 'package:store/features/home_page/domain/entities/category_entity.dart';
import 'package:store/features/home_page/domain/entities/product_entity.dart';

import '../../domain/repositories/home_products_repository.dart';

class HomeProductsRepositoryImplLocal implements HomeProductsRepository {
  @override
  Future<DataState<List<ProductEntity>>> fetchHomeProducts({required int categoryId}) async {
    try {
      final result = await DataProvider().homeGetProductsByCategory(category_id: categoryId);
      List  products = HomeProductsModel.fromJson(result).products!;
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
}
