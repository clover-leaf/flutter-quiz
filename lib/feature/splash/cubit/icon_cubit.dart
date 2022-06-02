import 'package:bloc/bloc.dart';

class IconCubit extends Cubit<int> {
  IconCubit() : super(0);

  void increase() {
    emit(state + 1);
  }
}
