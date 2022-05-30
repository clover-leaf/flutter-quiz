import 'package:bloc/bloc.dart';
import 'package:chicken/data/test_api/source/model/model.dart';
import 'package:equatable/equatable.dart';

import 'package:chicken/domain/test_repository/test_repository.dart'
    show TestRepository;

part 'repository_event.dart';
part 'repository_state.dart';

class RepositoryBloc extends Bloc<RepositoryEvent, RepositoryState> {
  RepositoryBloc({required testRepository})
      : _testRepository = testRepository,
        super(RepositoryInitial()) {
    on<GetCategoryList>(_onGetCategoryList);
  }

  final TestRepository _testRepository;

  Future<void> _onGetCategoryList(
      GetCategoryList event, Emitter<RepositoryState> emit) async {
    emit(RepositoryLoading());
    try {
      List<TestCategory> categoryList = await _testRepository.getCategoryList();
      List<TestDifficulty> difficultyList = _testRepository.getDifficultyList();
      List<TestType> typeList = _testRepository.getTypeList();
      emit(RepositorySuccess(
          categoryList: categoryList,
          difficultyList: difficultyList,
          typeList: typeList));
    } catch (e) {
      print(e);
      emit(RepositoryError());
    }
  }
}
