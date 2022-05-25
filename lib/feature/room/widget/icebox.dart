import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chicken/common/common.dart';
import 'package:chicken/feature/room/room.dart';
import 'package:chicken/data/test_api/test_api.dart' show Answer;

class Icebox extends StatelessWidget {
  const Icebox({
    super.key,
    this.height = 40,
    this.width = 48,
    this.borderRadius = 8,
    this.borderWidth = 1.6,
    required this.quizIndex,
  });

  final double height, width, borderRadius, borderWidth;
  final int quizIndex;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: height,
        width: width,
        child: Stack(alignment: Alignment.bottomCenter, children: [
          BlocBuilder<UtilBloc, UtilState>(
            buildWhen: (previous, current) =>
                previous.answersheet[quizIndex].id !=
                current.answersheet[quizIndex].id,
            builder: (context, state) {
              Answer answer = state.answersheet[quizIndex];
              bool isAnswered = answer.id != -1;
              return Container(
                height: height - 4,
                width: width,
                decoration: isAnswered
                    ? BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        color: Color(Palette.black.color))
                    : const BoxDecoration(),
                child: Center(
                    child: Text('${answer.quizLabel}.${answer.label}',
                        style: TextStyle(
                          color: isAnswered
                              ? Colors.white
                              : Color(Palette.black.color),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ))),
              );
            },
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
              border: Border.all(
                  width: borderWidth, color: Color(Palette.black.color)),
            ),
          ),
        ]),
      ),
    );
  }
}
