import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:chicken/data/test_api/test_api.dart' show Answer;

part 'util_event.dart';
part 'util_state.dart';

class UtilBloc extends Bloc<UtilEvent, UtilState> {
  UtilBloc({required answersheet}) : super(UtilState(answersheet, -1, false)) {
    on<UpdateAnswer>(_onUpdateAnswer);
    on<ScrollRequest>(_onScrollRequest);
    on<ScrollSuccess>(_onScrollSuccess);
  }

  void _onUpdateAnswer(UpdateAnswer event, Emitter<UtilState> emit) {
    List<Answer> copiedSheet = List.from(state.answersheet);
    copiedSheet[event.quizIndex] = event.ans;
    return emit(state.copyWith(answersheet: copiedSheet));
  }

  void _onScrollRequest(ScrollRequest event, Emitter<UtilState> emit) {
    print('request');
    return emit(state.copyWith(tapIndex: event.quizIndex, isScroll: true));
  }
  void _onScrollSuccess(ScrollSuccess event, Emitter<UtilState> emit) {
    return emit(state.copyWith(isScroll: false));
  }
}
