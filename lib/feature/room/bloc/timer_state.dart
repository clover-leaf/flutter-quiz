part of 'timer_bloc.dart';

abstract class TimerState extends Equatable {
  final TestDuration? duration;

  const TimerState(this.duration);

  @override
  List<Object> get props => [];
}

class TimerInitial extends TimerState {
  const TimerInitial([super.duration]);
}

class TimerInfinity extends TimerState {
  const TimerInfinity([super.duration]);
}

class TimerRun extends TimerState {
  const TimerRun(super.duration);
  @override
  List<Object> get props => [duration!];
}
class TimerComplete extends TimerState {
  const TimerComplete(super.duration);
}
