part of 'answer_bloc.dart';

abstract class AnswerEvent extends Equatable {
  const AnswerEvent();

  @override
  List<Object> get props => [];
}

class UpdateAnswer extends AnswerEvent {
  final Answer ans;
  final int quizIndex;

  const UpdateAnswer(this.ans, this.quizIndex);
}
