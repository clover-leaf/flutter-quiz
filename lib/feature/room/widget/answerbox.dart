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
        padding: const EdgeInsets.only(top: 8.0),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            context.read<AnswerBloc>().add(UpdateAnswer(answer, quizIndex));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Firebox(
                    borderRadius: Constant.BORDER_RADIUS.value,
                    borderWidth: Constant.BORDER_WIDTH.value,
                    quizIndex: quizIndex,
                    text: answer.label,
                    answerId: answer.id,
                  )),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      answer.answer,
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
