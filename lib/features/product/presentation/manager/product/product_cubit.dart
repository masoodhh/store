import 'package:bloc/bloc.dart';
import 'package:store/features/cart/presentation/manager/checkout/checkout_bloc.dart';
import 'package:store/features/product/domin/use_cases/get_product_detail_usecase.dart';

import '../../../../../core/params/params.dart';
import '../../../../../core/resources/data_state.dart';
import '../../../../../logger.dart';
import '../../../../../main.dart';
import '../../../../home/domain/entities/product_entity.dart';
import '../../../domin/entities/product_detail_entity.dart';
import '../../../domin/entities/review_entity.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  GetProductDetailUsecase getProductDetailUsecase = locator();

  ProductCubit() : super(ProductState.initial());

  Future<void> initializeEvent(int product_id) async {
    final DataState<ProductDetailesEntity> result = await getProductDetailUsecase.call(product_id);
    if (result is DataSuccess) {
      final ProductDetailesEntity productDetailEntity = result.data!;
      emit(state.copyWith(
          newStatus: Status.SUCCESS,
          newReview: productDetailEntity.reviews,
          newSimilarProducts: productDetailEntity.similarProducts));
    } else {
      emit(state.copyWith(newStatus: Status.ERROR));
    }
  }
}
