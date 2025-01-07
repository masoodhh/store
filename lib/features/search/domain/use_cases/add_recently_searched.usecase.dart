import 'package:store/core/resources/data_state.dart';
import 'package:store/features/home/domain/repositories/home.repository.dart';

import '../../../../../../core/use_case/use_case.dart';
import '../../../home/domain/entities/product_entity.dart';
import '../../presentation/manager/search/search_bloc.dart';

class AddRecentlySearchedUsecase extends UseCase<void, String> {
  final HomeRepository homeRepository;

  AddRecentlySearchedUsecase(this.homeRepository);

  @override
  Future<void> call(String param) async {
    await homeRepository.addRecentlySearched(param);
    return;
  }
}
