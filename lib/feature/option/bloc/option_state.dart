// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'option_bloc.dart';

enum OptionStatus {initial, loading, success, failure}

class OptionState extends Equatable {
  final OptionStatus status;
  final TestDifficulty difficulty;
  final TestCategory category;
  final TestType type;
  final int duration;
  final List<Quiz> quizzes;
  
  const OptionState({
    this.status = OptionStatus.initial,
    this.difficulty = TestDifficulty.any,
    this.category = TestCategory.any,
    this.type = TestType.any,
    this.duration = 0,
    this.quizzes = const [],
  });

  OptionState copyWith({
    OptionStatus? status,
    TestDifficulty? difficulty,
    TestCategory? category,
    TestType? type,
    int? duration,
    List<Quiz>? quizzes,
  }) {
    return OptionState(
      status: status ?? this.status,
      difficulty: difficulty ?? this.difficulty,
      category: category ?? this.category,
      type: type ?? this.type,
      duration: duration ?? this.duration,
      quizzes: quizzes ?? this.quizzes,
    );
  }

  Map<String, String> toParameters() {
    return {'difficulty': difficulty.value, 'category': category.value, 'type': type.value};
  }

  @override
  String toString() => 'OptionState(status: $status, duration: $duration)';

  @override
  List<Object> get props => [status, difficulty, category, type, duration];
}
