part of 'load_bloc.dart';

abstract class LoadEvent extends Equatable {
  const LoadEvent();

  @override
  List<Object> get props => [];
}

class Loaded extends LoadEvent {
  final Map<String, String> parameters;

  const Loaded({required this.parameters});}



