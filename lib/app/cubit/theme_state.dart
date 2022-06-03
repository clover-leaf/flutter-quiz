part of 'theme_cubit.dart';

abstract class ThemeState extends Equatable {
  const ThemeState(this.isDark);

  final bool isDark;

  @override
  List<Object> get props => [isDark];
}

class ThemeInitial extends ThemeState {
  const ThemeInitial(super.isDark);
}

class ThemeLoaded extends ThemeState {
  const ThemeLoaded(super.isDark);
}