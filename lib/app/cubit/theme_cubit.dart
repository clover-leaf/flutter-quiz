import 'package:bloc/bloc.dart';


class ThemeCubit extends Cubit<bool> {
  ThemeCubit() : super(false);

  void toggle() {
    emit(!state);
  }
}
