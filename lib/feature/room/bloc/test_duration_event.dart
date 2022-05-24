part of 'test_duration_bloc.dart';

abstract class TestDurationEvent extends Equatable {
  const TestDurationEvent();

  @override
  List<Object> get props => [];
}

class TestDurationStarted extends TestDurationEvent {
  const TestDurationStarted();
}

class TestDurationPaused extends TestDurationEvent {
  const TestDurationPaused();
}

class TestDurationResumed extends TestDurationEvent {
  const TestDurationResumed();
}

class TestDurationTicked extends TestDurationEvent {
  const TestDurationTicked({required this.durationAfterTicked});

  final int durationAfterTicked;

  @override
  List<Object> get props => [durationAfterTicked];
}

class TestDurationShutdown extends TestDurationEvent {
  const TestDurationShutdown();
}
