part of 'repository_cubit.dart';

abstract class RepositoryState extends Equatable {
  const RepositoryState();

  @override
  List<Object> get props => [];
}

class RepositoryInitial extends RepositoryState {}

class RepositoryLoading extends RepositoryState {}

class RepositorySuccess extends RepositoryState {
  final List<TestCategory> categoryList;
  final List<TestDifficulty> difficultyList;
  final List<TestType> typeList;
  const RepositorySuccess(
      {required this.categoryList,
      required this.difficultyList,
      required this.typeList});
  @override
  List<Object> get props => [categoryList, difficultyList, typeList];
}

class RepositoryError extends RepositoryState {}
