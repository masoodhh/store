import 'package:bloc/bloc.dart';


class WrapperCubit extends Cubit<int> {
  WrapperCubit() : super(0);

  void changeTab(int index) {
    emit(index);
  }

}
