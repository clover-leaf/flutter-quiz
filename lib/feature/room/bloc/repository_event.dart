part of 'repository_bloc.dart';

abstract class RepositoryEvent extends Equatable {
  const RepositoryEvent();

  @override
  List<Object> get props => [];
}

class GetTest extends RepositoryEvent {
  final Map<String, String> parameters;

  const GetTest(this.parameters);
}
