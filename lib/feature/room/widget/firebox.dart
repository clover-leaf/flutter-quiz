import 'package:chicken/common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chicken/feature/room/room.dart';

class Firebox extends StatelessWidget {
  const Firebox({
    super.key,
    this.height = 32,
    this.width = 32,
    required this.borderRadius,
    required this.borderWidth,
    required this.text,
    required this.quizIndex,
    required this.answerId,
  });

  final double height, width, borderRadius, borderWidth;
  final String text;
  final int quizIndex;
  final int answerId;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Stack(alignment: Alignment.bottomCenter, children: [
        BlocBuilder<AnswerBloc, AnswerState>(
          buildWhen: (previous, current) {
            final prevId = previous.answersheet[quizIndex].id;
            final curId = current.answersheet[quizIndex].id;
            return (prevId != curId) &&
                (answerId == curId || answerId == prevId);
          },
          builder: (context, state) {
            final isActive = state.answersheet[quizIndex].id == answerId;
            final double animatedHeight = isActive ? height - 4 : 0;
            return AnimatedContainer(
              curve: Curves.easeOutCubic,
              height: animatedHeight,
              width: 16 + animatedHeight / height * 16,
              duration:  Duration(milliseconds: Constant.FILL_BOX_TRANS_DURATION.value.toInt()),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  color: Theme.of(context).primaryColor),
            );
          },
        ),
        BlocBuilder<AnswerBloc, AnswerState>(
          buildWhen: (previous, current) {
            final prevId = previous.answersheet[quizIndex].id;
            final curId = current.answersheet[quizIndex].id;
            return (prevId != curId) &&
                (answerId == curId || answerId == prevId);
          },
          builder: (context, state) {
            final isActive = state.answersheet[quizIndex].id == answerId;
            return Center(
                child: AnimatedDefaultTextStyle(
              curve: Curves.easeOutCubic,
              duration: Duration(milliseconds: Constant.FILL_BOX_TRANS_DURATION.value.toInt()),
              style: Theme.of(context).textTheme.headline1!.copyWith(
                    height: 1.6,
                    color: isActive ? Theme.of(context).scaffoldBackgroundColor : Theme.of(context).primaryColor,
                  ),
              child: Text(text),
            ));
          },
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
            border: Border.all(color: Theme.of(context).primaryColor, width: borderWidth),
          ),
        ),
      ]),
    );
  }
}
