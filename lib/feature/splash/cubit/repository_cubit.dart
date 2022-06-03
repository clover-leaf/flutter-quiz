import 'package:bloc/bloc.dart';
import 'package:chicken/data/test_api/test_api.dart'
    show TestCategory, TestDifficulty, TestType;
import 'package:chicken/domain/test_repository/test_repository.dart';
import 'package:equatable/equatable.dart';

part 'repository_state.dart';

class RepositoryCubit extends Cubit<RepositoryState> {
  RepositoryCubit({required TestRepository testRepository})
      : _testRepository = testRepository,
        super(RepositoryInitial());

  final TestRepository _testRepository;

  Future<void> getOption() async {
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
