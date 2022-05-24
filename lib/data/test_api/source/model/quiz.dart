// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:chicken/data/test_api/test_api.dart';

class Quiz {
  final int id;
  final String label;
  final String question;
  final List<Answer> answers;
  Quiz({
    required this.id,
    required this.label,
    required this.question,
    required this.answers,
  });

  Quiz copyWith({
    int? id,
    String? label,
    String? question,
    List<Answer>? answers,
  }) {
    return Quiz(
      id: id ?? this.id,
      label: label ?? this.label,
      question: question ?? this.question,
      answers: answers ?? this.answers,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'label': label,
      'question': question,
      'answers': answers.map((x) => x.toMap()).toList(),
    };
  }

  factory Quiz.fromMap(Map<String, dynamic> map) {
    return Quiz(
      id: map['id'] as int,
      label: map['label'] as String,
      question: map['question'] as String,
      answers: List<Answer>.from((map['answers'] as List<dynamic>).map<Answer>((x) => Answer.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory Quiz.fromJson(String source) => Quiz.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Quiz(id: $id, label: $label, question: $question, answers: $answers)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Quiz &&
      other.id == id &&
      other.label == label &&
      other.question == question &&
      listEquals(other.answers, answers);
  }

  @override
  int get hashCode {
    return id.hashCode ^
      label.hashCode ^
      question.hashCode ^
      answers.hashCode;
  }
}
