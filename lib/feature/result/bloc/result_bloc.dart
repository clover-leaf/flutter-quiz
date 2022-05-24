import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:chicken/data/test_api/test_api.dart' show Test;

part 'result_event.dart';
part 'result_state.dart';

class ResultBloc extends Bloc<ResultEvent, ResultState> {
  ResultBloc() : super(ResultInitial()) {
    on<ResultLoaded>(_onResultLoaded);
  }

  void _onResultLoaded(ResultLoaded event, Emitter<ResultState> emit) {
    emit(ResultLoadSuccess(test: event.test));
  }
}
