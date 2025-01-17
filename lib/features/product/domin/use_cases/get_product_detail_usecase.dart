import 'package:store/core/resources/data_state.dart';

import '../../../../core/use_case/use_case.dart';
import '../../../home/domain/repositories/home.repository.dart';
import '../entities/product_detail_entity.dart';

class GetProductDetailUsecase extends UseCase<DataState<ProductDetailesEntity>, int> {
  final HomeRepository homeRepository;

  GetProductDetailUsecase(this.homeRepository);

  @override
  Future<DataState<ProductDetailesEntity>> call(int product_id) {
    return homeRepository.getProductDetial(product_id: product_id);
  }
}
