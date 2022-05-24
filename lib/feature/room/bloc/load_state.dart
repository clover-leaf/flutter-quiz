part of 'load_bloc.dart';

abstract class LoadState extends Equatable {
  const LoadState();

  @override
  List<Object> get props => [];
}

class LoadInitial extends LoadState {}

class Loading extends LoadState {}

class LoadSuccess extends LoadState {
  final List<Quiz> quizzes;

  const LoadSuccess({required this.quizzes});
}

class LoadFailure extends LoadState {}
