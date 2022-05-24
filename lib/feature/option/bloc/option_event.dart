part of 'option_bloc.dart';

abstract class OptionEvent {}

// request get test
class OptionTestRequested extends OptionEvent {}

class OptionDifficultyChanged extends OptionEvent {
  final TestDifficulty difficulty;
  OptionDifficultyChanged({required this.difficulty});
}

class OptionCategoryChanged extends OptionEvent {
  final TestCategory category;
  OptionCategoryChanged({required this.category});
}

class OptionTypeChanged extends OptionEvent {
  final TestType type;
  OptionTypeChanged({required this.type});
}
