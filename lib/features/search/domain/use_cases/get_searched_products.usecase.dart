import 'package:store/core/resources/data_state.dart';
import 'package:store/features/home/domain/repositories/home.repository.dart';

import '../../../../../../core/use_case/use_case.dart';
import '../../../home/domain/entities/product_entity.dart';
import '../../presentation/manager/search/search_bloc.dart';

class GetSearchedProductsUsecase extends UseCase<DataState<List<ProductEntity>>, SearchFilter> {
  final HomeRepository homeRepository;

  GetSearchedProductsUsecase(this.homeRepository);

  @override
  Future<DataState<List<ProductEntity>>> call(SearchFilter param) async {
    // TODO: implement call
    final DataState<List<ProductEntity>> dataState =
        await homeRepository.getSearchedProducts(searchFilter: param);
    throw UnimplementedError();
  }
}
