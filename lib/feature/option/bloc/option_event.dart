part of 'option_bloc.dart';

abstract class OptionEvent {}

class OptionDifficultyChanged extends OptionEvent {
  final String difficulty;
  OptionDifficultyChanged({required this.difficulty});
}

class OptionCategoryChanged extends OptionEvent {
  final String category;
  OptionCategoryChanged({required this.category});
}

class OptionTypeChanged extends OptionEvent {
  final String type;
  OptionTypeChanged({required this.type});
}
