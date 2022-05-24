import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:chicken/feature/room/room.dart';
import 'package:chicken/data/test_api/test_api.dart' show TestDuration;

part 'test_duration_event.dart';
part 'test_duration_state.dart';

class TestDurationBloc extends Bloc<TestDurationEvent, TestDurationState> {
  final Ticker _ticker;

  StreamSubscription<int>? _tickerSubcription;

  TestDurationBloc({required Ticker ticker, required int duration})
      : _ticker = ticker,
        super(TestDurationInitial(TestDuration(total: duration, remain: duration))) {
    on<TestDurationStarted>(_onStarted);
    on<TestDurationTicked>(_onTicked);
    on<TestDurationPaused>(_onPaused);
    on<TestDurationResumed>(_onResumed);
  }

  @override
  Future<void> close() {
    _tickerSubcription?.cancel();
    return super.close();
  }

  void _onStarted(TestDurationStarted event, Emitter<TestDurationState> emit) {
    emit(TestDurationRunInProgress(state.duration));
    _tickerSubcription?.cancel();
    _tickerSubcription = _ticker.tick(ticks: state.duration.total).listen(
        (duration) => add(TestDurationTicked(durationAfterTicked: duration)));
  }

  void _onTicked(TestDurationTicked event, Emitter<TestDurationState> emit) {
    if (event.durationAfterTicked > 0) {
      emit(TestDurationRunInProgress(TestDuration(
          total: state.duration.total,
          remain: state.duration.remain - 1)));
    } else {
      emit(TestDurationRunComplete(state.duration));
    }
  }

  void _onPaused(TestDurationPaused event, Emitter<TestDurationState> emit) {
    if (state is TestDurationRunInProgress) {
      _tickerSubcription?.pause();
      emit(TestDurationRunPause(state.duration));
    }
  }

  void _onResumed(TestDurationResumed event, Emitter<TestDurationState> emit) {
    if (state is TestDurationRunPause) {
      _tickerSubcription?.resume();
      emit(TestDurationRunInProgress(state.duration));
    }
  }
}
