import 'package:bloc/bloc.dart';

class NavigatorCubit extends Cubit<int> {
  NavigatorCubit() : super(1);

  void setCurrentPage(int pageIndex) {
    emit(pageIndex);
  }
}
