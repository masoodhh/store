import 'package:bloc/bloc.dart';


class PageWrapperCubit extends Cubit<int> {
  PageWrapperCubit() : super(0);

  void changeTab(int index) {
    emit(index);
  }

}
