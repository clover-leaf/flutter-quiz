// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'model.dart';

class Test {
  final TestDifficulty difficulty;
  final TestType type;
  final TestCategory category;
  final TestDuration duration;
  final List<Answer> answers;
  final List<Quiz> quizzes;
  Test({
    required this.difficulty,
    required this.type,
    required this.category,
    required this.duration,
    required this.answers,
    required this.quizzes,
  });


  Test copyWith({
    TestDifficulty? difficulty,
    TestType? type,
    TestCategory? category,
    TestDuration? duration,
    List<Answer>? answers,
    List<Quiz>? quizzes,
  }) {
    return Test(
      difficulty: difficulty ?? this.difficulty,
      type: type ?? this.type,
      category: category ?? this.category,
      duration: duration ?? this.duration,
      answers: answers ?? this.answers,
      quizzes: quizzes ?? this.quizzes,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'difficulty': difficulty.toMap(),
      'type': type.toMap(),
      'category': category.toMap(),
      'duration': duration.toMap(),
      'answers': answers.map((x) => x.toMap()).toList(),
      'quizzes': quizzes.map((x) => x.toMap()).toList(),
    };
  }

  factory Test.fromMap(Map<String, dynamic> map) {
    return Test(
      difficulty: TestDifficulty.fromMap(map['difficulty']),
      type: TestType.fromMap(map['type']),
      category: TestCategory.fromMap(map['category']),
      duration: TestDuration.fromMap(map['duration'] as Map<String,dynamic>),
      answers: List<Answer>.from((map['answers'] as List<dynamic>).map<Answer>((x) => Answer.fromMap(x as Map<String,dynamic>),),),
      quizzes: List<Quiz>.from((map['quizzes'] as List<dynamic>).map<Quiz>((x) => Quiz.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory Test.fromJson(String source) => Test.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Test(difficulty: $difficulty, type: $type, category: $category, duration: $duration, answers: $answers, quizzes: $quizzes)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Test &&
      other.difficulty == difficulty &&
      other.type == type &&
      other.category == category &&
      other.duration == duration &&
      listEquals(other.answers, answers) &&
      listEquals(other.quizzes, quizzes);
  }

  @override
  int get hashCode {
    return difficulty.hashCode ^
      type.hashCode ^
      category.hashCode ^
      duration.hashCode ^
      answers.hashCode ^
      quizzes.hashCode;
  }
}
