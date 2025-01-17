import 'package:store/core/resources/data_state.dart';

import '../../../product/domin/entities/product_detail_entity.dart';
import '../../../search/presentation/manager/search/search_bloc.dart';
import '../entities/category_entity.dart';
import '../entities/product_entity.dart';

abstract class HomeRepository {
  Future<DataState<List<ProductEntity>>> fetchHomeProducts({required int categoryId});

  Future<DataState<List<CategoryEntity>>> fetchHomeCategories();

  Future<DataState<List<ProductEntity>>> getSearchedProducts({required SearchFilter searchFilter});

  Future<List<String>> getRecentlySearched();

  Future<void> addRecentlySearched(String text);

  Future<DataState<ProductDetailesEntity>> getProductDetial({required int product_id});
}
