import 'package:store/core/resources/data_state.dart';

import '../../../../core/use_case/use_case.dart';
import '../entities/product_entity.dart';
import '../repositories/home.repository.dart';

class GetProductsByCategoryUsecase
    extends UseCase<DataState<List<ProductEntity>>, int> {
  final HomeRepository homeProductsRepository;

  GetProductsByCategoryUsecase(this.homeProductsRepository);

  @override
  Future<DataState<List<ProductEntity>>> call(int categoryId) {
    return homeProductsRepository.fetchHomeProducts(categoryId: categoryId);
  }
}
