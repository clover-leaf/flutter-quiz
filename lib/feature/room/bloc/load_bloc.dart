import 'package:bloc/bloc.dart';
import 'package:chicken/data/test_api/test_api.dart' show Test;
import 'package:chicken/domain/test_repository/test_repository.dart';
import 'package:equatable/equatable.dart';

part 'load_event.dart';
part 'load_state.dart';

class LoadBloc extends Bloc<LoadEvent, LoadState> {
  LoadBloc({required testRepository})
      : _testRepository = testRepository,
        super(LoadInitial()) {
    on<Loaded>(_onLoaded);
  }

  final TestRepository _testRepository;

  Future<void> _onLoaded(Loaded event, Emitter<LoadState> emit) async {
    emit(Loading());
    try {
      Test test = await _testRepository.getTest(event.parameters);
      emit(LoadSuccess(test: test));
    } catch (e) {
      emit(LoadFailure());
    }
  }
}
