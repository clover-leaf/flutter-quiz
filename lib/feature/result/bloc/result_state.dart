part of 'result_bloc.dart';

abstract class ResultState extends Equatable {
  const ResultState();

  @override
  List<Object> get props => [];
}

class ResultInitial extends ResultState {}

class ResultLoading extends ResultState {}

class ResultLoadSuccess extends ResultState {
  const ResultLoadSuccess({required this.test});

  final Test test;

  @override
  List<Object> get props => [test];

  int get getCorrectAnswer {
    return test.answers
        .map((ans) => ans.isCorrect ? 1 : 0)
        .reduce((prev, next) => prev + next);
  }
}
