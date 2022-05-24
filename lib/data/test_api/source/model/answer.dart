// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Answer {
  final int id;
  final int quizId;
  final String quizLabel;
  final String label;
  final String answer;
  final bool isCorrect;
  Answer({
    required this.id,
    required this.quizId,
    required this.quizLabel,
    required this.label,
    required this.answer,
    required this.isCorrect,
  });

  Answer copyWith({
    int? id,
    int? quizId,
    String? quizLabel,
    String? label,
    String? answer,
    bool? isCorrect,
  }) {
    return Answer(
      id: id ?? this.id,
      quizId: quizId ?? this.quizId,
      quizLabel: quizLabel ?? this.quizLabel,
      label: label ?? this.label,
      answer: answer ?? this.answer,
      isCorrect: isCorrect ?? this.isCorrect,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'quizId': quizId,
      'quizLabel': quizLabel,
      'label': label,
      'answer': answer,
      'isCorrect': isCorrect,
    };
  }

  factory Answer.fromMap(Map<String, dynamic> map) {
    return Answer(
      id: map['id'] as int,
      quizId: map['quizId'] as int,
      quizLabel: map['quizLabel'] as String,
      label: map['label'] as String,
      answer: map['answer'] as String,
      isCorrect: map['isCorrect'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Answer.fromJson(String source) => Answer.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Answer(id: $id, quizId: $quizId, quizLabel: $quizLabel, label: $label, answer: $answer, isCorrect: $isCorrect)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Answer &&
      other.id == id &&
      other.quizId == quizId &&
      other.quizLabel == quizLabel &&
      other.label == label &&
      other.answer == answer &&
      other.isCorrect == isCorrect;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      quizId.hashCode ^
      quizLabel.hashCode ^
      label.hashCode ^
      answer.hashCode ^
      isCorrect.hashCode;
  }
}
