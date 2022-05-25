part of 'util_bloc.dart';

abstract class UtilEvent extends Equatable {
  const UtilEvent();

  @override
  List<Object> get props => [];
}

class UpdateAnswer extends UtilEvent {
  final Answer ans;
  final int quizIndex;

  const UpdateAnswer(this.ans, this.quizIndex);
}

class ScrollRequest extends UtilEvent {
  final int quizIndex;

  const ScrollRequest(this.quizIndex);
}

class ScrollSuccess extends UtilEvent {}