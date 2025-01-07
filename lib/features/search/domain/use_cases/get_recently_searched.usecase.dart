import 'package:store/core/resources/data_state.dart';
import 'package:store/features/home/domain/repositories/home.repository.dart';

import '../../../../../../core/use_case/use_case.dart';
import '../../../home/domain/entities/product_entity.dart';
import '../../presentation/manager/search/search_bloc.dart';

class GetRecentlySearchedUsecase extends NoParamUseCase<List<String>> {
  final HomeRepository homeRepository;

  GetRecentlySearchedUsecase(this.homeRepository);

  @override
  Future<List<String>> call() async {
    final List<String> dataState = await homeRepository.getRecentlySearched();
    return dataState;
  }
}
