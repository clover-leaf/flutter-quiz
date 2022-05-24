import 'package:bloc/bloc.dart';
import 'package:chicken/data/test_api/test_api.dart';
import 'package:equatable/equatable.dart';

part 'option_event.dart';
part 'option_state.dart';

class OptionBloc extends Bloc<OptionEvent, OptionState> {
  OptionBloc() : super(const OptionState()) {
    on<OptionDifficultyChanged>(_onOptionDifficultyChanged);
    on<OptionCategoryChanged>(_onOptionCategoryChanged);
    on<OptionTypeChanged>(_onOptionTypeChanged);
  }

  void _onOptionDifficultyChanged(
      OptionDifficultyChanged event, Emitter<OptionState> emit) {
    emit(state.copyWith(difficulty: event.difficulty));
  }

  void _onOptionCategoryChanged(
      OptionCategoryChanged event, Emitter<OptionState> emit) {
    emit(state.copyWith(category: event.category));
  }

  void _onOptionTypeChanged(
      OptionTypeChanged event, Emitter<OptionState> emit) {
    emit(state.copyWith(type: event.type));
  }
}
