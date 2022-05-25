part of 'timer_bloc.dart';

abstract class TimerEvent extends Equatable {
  const TimerEvent();

  @override
  List<Object> get props => [];
}

class TimerStart extends TimerEvent {
  final TestDuration duration;

  const TimerStart(this.duration);
}

class Tick extends TimerEvent {
  final int time_remain;

  const Tick(this.time_remain);
}
