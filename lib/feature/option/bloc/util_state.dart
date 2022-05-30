part of 'util_bloc.dart';

class UtilState extends Equatable {
  const UtilState( {
    required this.difficultyList,
    required this.categoryList,
    required this.typeList,
    required this.difficultyIndex,
    required this.categoryIndex,
    required this.typeIndex,
    required this.duration,
    required this.amount,
  });

  final List<TestDifficulty> difficultyList;
  final List<TestCategory> categoryList;
  final List<TestType> typeList;
  final int difficultyIndex;
  final int categoryIndex;
  final int typeIndex;
  final TestDuration duration;
  final int amount;

  UtilState copyWith({
    List<TestDifficulty>? difficultyList,
    List<TestCategory>? categoryList,
    List<TestType>? typeList,
    int? difficultyIndex,
    int? categoryIndex,
    int? typeIndex,
    TestDuration? duration,
    int? amount,
  }) {
    return UtilState(
      difficultyList: difficultyList ?? this.difficultyList,
      categoryList: categoryList ?? this.categoryList,
      typeList: typeList ?? this.typeList,
      difficultyIndex: difficultyIndex ?? this.difficultyIndex,
      categoryIndex: categoryIndex ?? this.categoryIndex,
      typeIndex: typeIndex ?? this.typeIndex,
      duration: duration ?? this.duration,
      amount: amount ?? this.amount,
    );
  }
  
  @override
  List<Object> get props => [difficultyIndex, categoryIndex, typeIndex, duration, amount];
}
