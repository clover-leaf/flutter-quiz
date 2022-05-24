import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:chicken/data/test_api/test_api.dart';

part 'room_event.dart';
part 'room_state.dart';

class RoomBloc extends Bloc<RoomEvent, RoomState> {
  RoomBloc() : super(RoomInitial()) {
    on<RoomCreated>(_onRoomCreated);
    on<RoomUpdated>(_onRoomUpdated);
    on<RoomNavbarTapped>(_onRoomNavbarTapped);
    on<RoomNavbarReset>(_onRoomNavbarReset);
  }

  void _onRoomCreated(RoomCreated event, Emitter<RoomState> emit) {
    final List<Answer> answerSheet = [];
    for (var quiz in event.quizzes) {
      answerSheet.add(Answer(
          id: -1,
          quizId: quiz.id,
          quizLabel: quiz.label,
          label: '',
          answer: '',
          isCorrect: false));
    }
    emit(RoomUpdating(answerSheet: answerSheet));
  }

  void _onRoomUpdated(RoomUpdated event, Emitter<RoomState> emit) {
    final updateQuizIndex = state.answerSheet
        .map((ans) => ans.quizId)
        .toList()
        .indexOf(event.answer.quizId);
    if (updateQuizIndex == -1) {
      throw Exception('quiz not found');
    }
    List<Answer> updateSheet = List.from(state.answerSheet);
    updateSheet[updateQuizIndex] = event.answer;
    emit(RoomUpdating(answerSheet: updateSheet));
  }

  void _onRoomNavbarTapped(RoomNavbarTapped event, Emitter<RoomState> emit) {
    emit(RoomUpdating(answerSheet: state.answerSheet, navbarIdx: event.index, navbarTap: event.isTap));
  }

  void _onRoomNavbarReset(RoomNavbarReset event, Emitter<RoomState> emit) {
    emit(RoomUpdating(answerSheet: state.answerSheet, navbarTap: false, navbarIdx: -1));
  }
}
