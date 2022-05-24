// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'option_bloc.dart';

class OptionState extends Equatable {
  final String difficulty;
  final String category;
  final String type;
  final int duration;
  final List<Quiz> quizzes;
  
   const OptionState({
    this.difficulty = 'Any',
    this.category = 'Any',
    this.type = 'Any',
    this.duration = 0,
    this.quizzes = const [],
  });

  OptionState copyWith({
    String? difficulty,
    String? category,
    String? type,
    int? duration,
    List<Quiz>? quizzes,
  }) {
    return OptionState(
      difficulty: difficulty ?? this.difficulty,
      category: category ?? this.category,
      type: type ?? this.type,
      duration: duration ?? this.duration,
      quizzes: quizzes ?? this.quizzes,
    );
  }


  @override
  List<Object> get props => [difficulty, category, type, duration];
}
