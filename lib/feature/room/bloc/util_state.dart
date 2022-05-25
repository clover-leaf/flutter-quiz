part of 'util_bloc.dart';

class UtilState extends Equatable {
  const UtilState(this.answersheet, this.tapIndex, this.isScroll);

  final List<Answer> answersheet;
  final int tapIndex;
  final bool isScroll;

  @override
  List<Object> get props => [answersheet, tapIndex, isScroll];

  UtilState copyWith({
    List<Answer>? answersheet,
    int? tapIndex,
    bool? isScroll,
  }) {
    return UtilState(answersheet ?? this.answersheet, tapIndex ?? this.tapIndex,
        isScroll ?? this.isScroll);
  }
}
