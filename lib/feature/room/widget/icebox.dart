import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chicken/feature/room/room.dart';
import 'package:chicken/data/test_api/test_api.dart' show Answer;

class Icebox extends StatelessWidget {
  const Icebox({
    super.key,
    this.height = 40,
    this.width = 40,
    this.borderRadius = 8,
    this.borderWidth = 1.6,
    required this.quizIndex,
  });

  final double height, width, borderRadius, borderWidth;
  final int quizIndex;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        context.read<UtilBloc>().add(ScrollRequest(quizIndex));
        context.read<UtilBloc>().add(ToggleTab());
      },
      child: Center(
        child: SizedBox(
          height: height,
          width: width,
          child: BlocBuilder<AnswerBloc, AnswerState>(
            buildWhen: (previous, current) =>
                previous.answersheet[quizIndex].id !=
                current.answersheet[quizIndex].id,
            builder: (context, state) {
              Answer answer = state.answersheet[quizIndex];
              bool isAnswered = answer.id != -1;
              return isAnswered
                  ? Container(
                      height: height,
                      width: width,
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.all(Radius.circular(borderRadius)),
                          color: Theme.of(context).scaffoldBackgroundColor),
                      child: Center(
                          child: Text(
                              '${answer.quizLabel}${answer.label.toLowerCase()}',
                              style: isAnswered
                                  ? Theme.of(context).textTheme.headline1
                                  : Theme.of(context).textTheme.headline2)))
                  : Container(
                      height: height,
                      width: width,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.circular(borderRadius)),
                        border: Border.all(
                            width: borderWidth,
                            color: Theme.of(context).scaffoldBackgroundColor),
                      ),
                      child: Center(
                          child: Text(answer.quizLabel,
                              style: isAnswered
                                  ? Theme.of(context).textTheme.headline1
                                  : Theme.of(context).textTheme.headline2)));
            },
          ),
        ),
      ),
    );
  }
}
