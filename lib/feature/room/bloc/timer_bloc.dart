import 'package:bloc/bloc.dart';
import 'dart:async';
import 'package:equatable/equatable.dart';

import 'package:chicken/feature/room/room.dart';
import 'package:chicken/data/test_api/test_api.dart' show TestDuration;

part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  StreamSubscription<int>? _tickerSubcription;

  TimerBloc() : super(const TimerInitial()) {
    on<TimerStart>(_onTimerStart);
    on<Tick>(_onTick);
  }

  @override
  Future<void> close() {
    _tickerSubcription?.cancel();
    return super.close();
  }

  void _onTimerStart(TimerStart event, Emitter<TimerState> emit) {
    if (event.duration.total == 0) {
      emit(const TimerInfinity());
    } else {
      emit(TimerRun(event.duration));
      _tickerSubcription?.cancel();
      _tickerSubcription =
          Ticker.tick(ticks: state.duration!.total).listen((duration) {
        add(Tick(duration));
      });
    }
  }

  void _onTick(Tick event, Emitter<TimerState> emit) {
    if (state.duration == null) return;
    if (event.time_remain > 0) {
      emit(TimerRun(TestDuration(
          remain: state.duration!.remain - 1, total: state.duration!.total)));
    } else {
      emit(TimerComplete(state.duration));
    }
  }
}
