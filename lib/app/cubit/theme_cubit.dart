import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeInitial(true)) {
    getPref();
  }

  Future<void> getPref() async {
    final prefs = await SharedPreferences.getInstance();
    final bool isDark = prefs.getBool('isDark') ?? false;
    emit(ThemeLoaded(isDark));
  }

  Future<void> toggle() async {
    emit(ThemeLoaded(!state.isDark));
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDark', state.isDark);
  }
}
