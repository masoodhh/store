import 'package:store/core/resources/data_state.dart';
import 'package:store/features/home_page/domain/entities/produc_entity.dart';
import 'package:store/features/home_page/domain/repositories/home_products_repository.dart';

import '../../../../core/use_case/use_case.dart';

class GetProductsByCategoryUsecase
    extends UseCase<DataState<List<ProductEntity>>, int> {
  final HomeProductsRepository homeProductsRepository;

  GetProductsByCategoryUsecase(this.homeProductsRepository);

  @override
  Future<DataState<List<ProductEntity>>> call(int categoryId) {
    return homeProductsRepository.fetchHomeProducts(categoryId: categoryId);
  }
}
