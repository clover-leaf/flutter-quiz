part of 'repository_bloc.dart';

abstract class RepositoryState extends Equatable {
  const RepositoryState();

  @override
  List<Object> get props => [];
}

class RepositoryInitial extends RepositoryState {}

class RepositoryLoading extends RepositoryState {}

class RepositoryLoaded extends RepositoryState {
  final Test test;

  const RepositoryLoaded(this.test);
}

class RepositoryError extends RepositoryState {
  final String? msg;

  const RepositoryError([this.msg]);
}
