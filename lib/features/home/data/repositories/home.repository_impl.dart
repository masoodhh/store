import 'package:store/core/resources/data_state.dart';
import 'package:store/features/search/presentation/manager/search/search_bloc.dart';

import '../../domain/entities/category_entity.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/home.repository.dart';
import '../data_sources/data_provider.dart';
import '../models/category_model.dart';
import '../models/home_products_model.dart';

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
}
