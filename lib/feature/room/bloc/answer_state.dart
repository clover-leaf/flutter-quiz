part of 'answer_bloc.dart';

class AnswerState extends Equatable {
  const AnswerState({required this.answersheet});
  final List<Answer> answersheet;
  
  @override
  List<Object> get props => [answersheet];

  AnswerState copyWith({
    List<Answer>? answersheet
  }) {
    return AnswerState(answersheet: answersheet ?? this.answersheet);
  }
}
