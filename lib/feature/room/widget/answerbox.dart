import 'package:chicken/common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chicken/data/test_api/test_api.dart' show Answer;
import 'package:chicken/feature/room/room.dart';

class AnswerBox extends StatelessWidget {
  const AnswerBox({Key? key, required this.answer, required this.quizIndex})
      : super(key: key);

  final Answer answer;
  final int quizIndex;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: GestureDetector(
          onTap: () =>
              context.read<UtilBloc>().add(UpdateAnswer(answer, quizIndex)),
          child: Container(
            height: 56,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                border:
                    Border.all(color: Color(Palette.black.color), width: 1.6)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 16, 0),
                    child: Firebox(
                      quizIndex: quizIndex,
                      text: answer.label,
                      answerId: answer.id,
                    )),
                Expanded(
                  child: Text(
                    answer.answer,
                    style: TextStyle(
                        color: Color(Palette.black.color),
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        height: 1.4),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
