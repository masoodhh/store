import 'package:store/core/resources/data_state.dart';

import '../../../../core/use_case/use_case.dart';
import '../entities/category_entity.dart';
import '../repositories/home.repository.dart';

class GetCategoriesUsecase extends NoParamUseCase<DataState<List<CategoryEntity>>> {
  final HomeRepository homeRepository;

  GetCategoriesUsecase(this.homeRepository);

  @override
  Future<DataState<List<CategoryEntity>>> call() {
    return homeRepository.fetchHomeCategories();
  }
}
