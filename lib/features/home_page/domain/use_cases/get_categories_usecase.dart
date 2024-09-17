import 'package:store/core/resources/data_state.dart';
import 'package:store/features/home_page/domain/entities/category_entity.dart';
import 'package:store/features/home_page/domain/repositories/home_products_repository.dart';

import '../../../../core/use_case/use_case.dart';

class GetCategoriesUsecase extends NoParamUseCase<DataState<List<CategoryEntity>>> {
  final HomeProductsRepository homeProductsRepository;

  GetCategoriesUsecase(this.homeProductsRepository);

  @override
  Future<DataState<List<CategoryEntity>>> call() {
    return homeProductsRepository.fetchHomeCategories();
  }
}
