import 'package:store/core/resources/data_state.dart';
import 'package:store/features/home_page/domain/entities/category_entity.dart';
import 'package:store/features/home_page/domain/entities/product_entity.dart';

abstract class HomeProductsRepository {
  Future<DataState<List<ProductEntity>>> fetchHomeProducts({required int categoryId});
  Future<DataState<List<CategoryEntity>>> fetchHomeCategories();
}
