import 'package:chicken/feature/room/room.dart';
import 'package:flutter/material.dart';

import 'package:chicken/data/test_api/test_api.dart' show Quiz;

class Quizbox extends StatelessWidget {
  const Quizbox({Key? key, required this.quiz, required this.quizIndex}) : super(key: key);

  final Quiz quiz;
  final int quizIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Text(
            '${quiz.label}.',
            style: const TextStyle(height: 1.4),
          ),
        ),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              quiz.question,
              style: const TextStyle(height: 1.4),
            ),
            const SizedBox(
              height: 16,
            ),
            ...List.generate(quiz.answers.length, (ansIndex) {
              final answer = quiz.answers[ansIndex];
              return AnswerBox(answer: answer, quizIndex: quizIndex);
            })
          ],
        ))
      ],
    );
  }
}
