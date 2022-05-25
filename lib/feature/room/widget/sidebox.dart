import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'package:chicken/feature/room/room.dart';
import 'package:chicken/common/common.dart';

class Sidebox extends StatelessWidget {
  const Sidebox(
      {Key? key, required this.numberOfQuiz, required this.scaffoldKey})
      : super(key: key);

  final int numberOfQuiz;
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Drawer(
        elevation: 0,
        width: 96,
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 120, horizontal: 8),
          child: Column(
            children: [
              SizedBox(
                height: 40,
                child: Center(
                  child: Text(
                    'Answer',
                    style: TextStyle(
                      color: Color(Palette.black.color),
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 480,
                child: ScrollablePositionedList.separated(
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 8,
                        ),
                    itemCount: numberOfQuiz,
                    itemBuilder: (context, quizIndex) {
                      return GestureDetector(
                          onTap: () async {
                            context
                                .read<UtilBloc>()
                                .add(ScrollRequest(quizIndex));
                            await Future.delayed(
                              const Duration(milliseconds: 16),
                              () => scaffoldKey.currentState?.closeEndDrawer(),
                            );
                          },
                          child: Icebox(quizIndex: quizIndex));
                    }),
              ),
              // GestureDetector(
              //   onTap: () {
              //     Navigator.of(context).push(MaterialPageRoute(
              //         builder: (context) => ResultPage(
              //               parameters: loadState.test
              //                   .copyWith(
              //                       answers: answersheet,
              //                       duration: testDurationState.duration)
              //                   .toMap(),
              //             )));
              //     context.read<TestDurationBloc>().close();
              //   },
              //   child: Coolbox(
              //     width: 64,
              //     bgColor: Color(Palette.sapphire.color),
              //     child: const Text('Submit',
              //         style: TextStyle(
              //           color: Colors.white,
              //           fontSize: 13,
              //           fontWeight: FontWeight.bold,
              //         )),
              //   ),
              // )
            ],
          ),
        ));
  }
}
