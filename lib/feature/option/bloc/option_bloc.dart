import 'package:bloc/bloc.dart';
import 'package:chicken/data/test_api/test_api.dart';
import 'package:equatable/equatable.dart';
import 'package:chicken/domain/test_repository/test_repository.dart';
import 'package:chicken/common/common.dart';

part 'option_event.dart';
part 'option_state.dart';

class OptionBloc extends Bloc<OptionEvent, OptionState> {
  OptionBloc({required TestRepository testRepository})
      : _testRepository = testRepository,
        super(const OptionState()) {
    on<OptionTestRequested>(_onOptionTestRequested);
    on<OptionDifficultyChanged>(_onOptionDifficultyChanged);
    on<OptionCategoryChanged>(_onOptionCategoryChanged);
    on<OptionTypeChanged>(_onOptionTypeChanged);
  }

  final TestRepository _testRepository;

  Future<void> _onOptionTestRequested(
      OptionTestRequested event, Emitter<OptionState> emit) async {
    emit(state.copyWith(status: OptionStatus.loading));
    try {
      final quizzes = await _testRepository.getTest(state.toParameters());
      emit(const OptionState().copyWith(
        status: OptionStatus.success,
        quizzes: quizzes,
      ));
    } catch (_) {
      emit(const OptionState().copyWith(status: OptionStatus.failure));
    }
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
