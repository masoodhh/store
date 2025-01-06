import 'package:store/core/resources/data_state.dart';

import '../../../search/presentation/manager/search/search_bloc.dart';
import '../entities/category_entity.dart';
import '../entities/product_entity.dart';

abstract class HomeRepository {
  Future<DataState<List<ProductEntity>>> fetchHomeProducts({required int categoryId});
  Future<DataState<List<CategoryEntity>>> fetchHomeCategories();

  Future<DataState<List<ProductEntity>>> getSearchedProducts({required SearchFilter searchFilter});
}
