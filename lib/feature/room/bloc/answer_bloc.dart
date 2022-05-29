import 'package:bloc/bloc.dart';
import 'package:chicken/data/test_api/source/model/answer.dart';
import 'package:equatable/equatable.dart';

part 'answer_event.dart';
part 'answer_state.dart';

class AnswerBloc extends Bloc<AnswerEvent, AnswerState> {
  AnswerBloc({required answersheet}) : super(AnswerState(answersheet: answersheet)) {
    on<UpdateAnswer>(_onUpdateAnswer);
  }

  void _onUpdateAnswer(UpdateAnswer event, Emitter<AnswerState> emit) {
    List<Answer> copiedSheet = List.from(state.answersheet);
    copiedSheet[event.quizIndex] = event.ans;
    return emit(state.copyWith(answersheet: copiedSheet));
  }
}
