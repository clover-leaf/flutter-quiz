
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:chicken/data/test_api/test_api.dart' show Test;
import 'package:chicken/domain/test_repository/test_repository.dart';

part 'repository_event.dart';
part 'repository_state.dart';

class RepositoryBloc extends Bloc<RepositoryEvent, RepositoryState> {
  RepositoryBloc({required testRepository})
      : _testRepository = testRepository,
        super(RepositoryInitial()) {
    on<GetTest>(_onGetTest);
  }

  final TestRepository _testRepository;

  Future<void> _onGetTest(GetTest event, Emitter<RepositoryState> emit) async {
    emit(RepositoryLoading());
    try {
      Test test = await _testRepository.getTest(event.parameters);
      await Future.delayed(const Duration(milliseconds: 1000), () => emit(RepositoryLoaded(test)));
    } catch (e) {
      print(e);
      emit(const RepositoryError());
    }
  }
}
