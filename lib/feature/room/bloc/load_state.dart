part of 'load_bloc.dart';

abstract class LoadState extends Equatable {
  const LoadState();

  @override
  List<Object> get props => [];
}

class LoadInitial extends LoadState {}

class Loading extends LoadState {}

class LoadSuccess extends LoadState {
  final Test test;

  const LoadSuccess({required this.test});
}

class LoadFailure extends LoadState {}
