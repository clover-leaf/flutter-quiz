import 'package:chicken/common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chicken/feature/room/room.dart';

class Firebox extends StatelessWidget {
  const Firebox({
    super.key,
    this.height = 32,
    this.width = 32,
    this.borderRadius = 8,
    this.borderWidth = 1.6,
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
        BlocBuilder<UtilBloc, UtilState>(
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
              width: animatedHeight < 16 ? animatedHeight + 8 : width,
              duration: const Duration(milliseconds: 400),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  color: Color(Palette.black.color)),
            );
          },
        ),
        BlocBuilder<UtilBloc, UtilState>(
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
              duration: const Duration(milliseconds: 400),
              style: TextStyle(
                  color: isActive ? Colors.white : Color(Palette.black.color),
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  height: 1.4),
              child: Text(text),
            ));
          },
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
            border: Border.all(color: Colors.black, width: borderWidth),
          ),
        ),
      ]),
    );
  }
}
