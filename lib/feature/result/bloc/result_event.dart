part of 'result_bloc.dart';

abstract class ResultEvent extends Equatable {
  const ResultEvent();

  @override
  List<Object> get props => [];
}

class ResultLoaded extends ResultEvent {
  final Test test;

  const ResultLoaded({required this.test});

  @override
  List<Object> get props => [test];
}
