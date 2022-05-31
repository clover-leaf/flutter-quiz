import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<bool> {
  ThemeCubit() : super(false) {
    getPref();
  }

  Future<void> getPref() async {
    final prefs = await SharedPreferences.getInstance();
    final bool isDark = prefs.getBool('isDark') ?? false;
    emit(isDark);
  }

  Future<void> toggle() async {
    emit(!state);
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDark', state);
  }
}
