part of 'test_duration_bloc.dart';

abstract class TestDurationState extends Equatable {
  const TestDurationState(this.duration);

  final TestDuration duration;

  @override
  List<Object> get props => [duration];
}

class TestDurationInitial extends TestDurationState {
  
  const TestDurationInitial(super.duration);

  @override
  String toString() => "TestDurationInitial {duration: $duration}";
}

class TestDurationRunPause extends TestDurationState {
  const TestDurationRunPause(super.duration) ;

  @override
  String toString() => "TestDurationRunPause {duration: $duration}";
}

class TestDurationRunInProgress extends TestDurationState {
  const TestDurationRunInProgress(super.duration);

  @override
  String toString() => "TestDurationRunInProgress {duration: $duration}";
}

class TestDurationRunComplete extends TestDurationState {
  const TestDurationRunComplete(super.duration);

  @override
  String toString() => "TestDurationRunComplete {duration: $duration}";
}