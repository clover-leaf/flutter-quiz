import 'package:chicken/common/common.dart';
import 'package:chicken/data/test_api/test_api.dart' show Answer;
import 'package:chicken/domain/test_repository/source/test_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chicken/feature/result/result.dart' show ResultPage;
import 'package:chicken/feature/room/room.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class RoomPage extends StatelessWidget {
  const RoomPage({Key? key, required this.parameters}) : super(key: key);

  // parameters = {
  //   String type?  // value of type in url
  //   String category?  // value of category in url
  //   String difficulty?  // value of difficulty in url
  //   String duration!
  //   String amount!
  // }
  final Map<String, String> parameters;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) =>
            LoadBloc(testRepository: context.read<TestRepository>())
              ..add(Loaded(parameters: parameters)),
      ),
      BlocProvider(
        create: (context) => RoomBloc(),
      ),
      BlocProvider(
          create: (context) => TestDurationBloc(
              ticker: const Ticker(),
              duration: int.parse(parameters['duration']!))),
    ], child: RoomView());
  }
}

class RoomView extends StatelessWidget {
  RoomView({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final ItemScrollController itemScrollController = ItemScrollController();

  @override
  Widget build(BuildContext context) {
    final testDurationState = context.watch<TestDurationBloc>().state;
    final loadState = context.watch<LoadBloc>().state;
    final navbarIdx = context.select<RoomBloc, int>((e) => e.state.navbarIdx);
    final navbarIsTapped =
        context.select<RoomBloc, bool>((e) => e.state.navbarTap);
    final answerSheetState =
        context.select<RoomBloc, List<Answer>>((e) => e.state.answerSheet);

    return Scaffold(
      key: scaffoldKey,
      endDrawer: Drawer(
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
                      itemCount: answerSheetState.length,
                      itemBuilder: (context, idx) {
                        final ans = answerSheetState[idx];
                        final bool isAnswered = ans.id != -1;
                        return GestureDetector(
                          onTap: () {
                            context
                                .read<RoomBloc>()
                                .add(RoomNavbarTapped(index: idx, isTap: true));
                            Future.delayed(
                              const Duration(milliseconds: 16),
                              () => scaffoldKey.currentState!.closeEndDrawer(),
                            );
                          },
                          child: Coolbox(
                            width: 52,
                            bgColor: isAnswered
                                ? Color(Palette.black.color)
                                : Colors.white,
                            child: Text('${ans.quizLabel}.${ans.label}',
                                style: TextStyle(
                                  color: isAnswered
                                      ? Colors.white
                                      : Color(Palette.black.color),
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        );
                      }),
                ),
                GestureDetector(
                  onTap: () {
                    if (loadState is LoadSuccess) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ResultPage(
                                parameters: loadState.test
                                    .copyWith(
                                        answers: answerSheetState,
                                        duration: testDurationState.duration)
                                    .toMap(),
                              )));
                      context.read<TestDurationBloc>().close();
                    }
                  },
                  child: Coolbox(
                    width: 64,
                    bgColor: Color(Palette.sapphire.color),
                    child: const Text('Submit',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                )
              ],
            ),
          )),
      onEndDrawerChanged: (isOpen) {
        if (!isOpen & navbarIsTapped) {
          itemScrollController.scrollTo(
              index: navbarIdx, duration: const Duration(milliseconds: 600));
          context.read<RoomBloc>().add(RoomNavbarReset());
        }
      },
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => {print('tap')},
                    child: SizedBox(
                        height: 24,
                        width: 24,
                        child: Center(
                          child: Image.asset('assets/images/chevron.png'),
                        )),
                  ),
                  if (testDurationState is TestDurationInitial)
                    const Coolbox(
                      bgColor: Colors.grey,
                      width: 64,
                    )
                  else if (testDurationState is TestDurationRunComplete)
                    Coolbox(
                      width: 64,
                      bgColor: Colors.white,
                      child: Text(
                        testDurationState.duration.getTotalTime(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 12,
                            color: Color(Palette.black.color),
                            fontWeight: FontWeight.w700,
                            height: 1.4),
                      ),
                    )
                  else
                    GestureDetector(
                        onTap: () {
                          if (testDurationState is TestDurationRunInProgress) {
                            context
                                .read<TestDurationBloc>()
                                .add(const TestDurationPaused());
                          } else {
                            context
                                .read<TestDurationBloc>()
                                .add(const TestDurationResumed());
                          }
                        },
                        child: Magicbox(
                          width: 64,
                          activeBgColor: Color(Palette.sapphire.color),
                          isActive:
                              testDurationState is TestDurationRunInProgress,
                          child: Text(
                            testDurationState.duration.getRemainTime(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 12,
                                color: testDurationState
                                        is TestDurationRunInProgress
                                    ? Colors.white
                                    : Color(Palette.black.color),
                                fontWeight: FontWeight.w700,
                                height: 1.4),
                          ),
                        )),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => scaffoldKey.currentState?.openEndDrawer(),
                    child: SizedBox(
                        height: 24,
                        width: 24,
                        child: Center(
                          child: Image.asset('assets/images/list.png'),
                        )),
                  ),
                ],
              ),
            ),
            (() {
              switch (loadState.runtimeType) {
                case Loading:
                  return const CircularProgressIndicator();
                case LoadSuccess:
                  if (testDurationState is TestDurationInitial) {
                    context.read<RoomBloc>().add(RoomCreated(
                        quizzes: (loadState as LoadSuccess).test.quizzes));
                  }
                  // when room bloc done creating answer sheet
                  if (answerSheetState.isNotEmpty) {
                    context
                        .read<TestDurationBloc>()
                        .add(const TestDurationStarted());
                    // build list quizzes
                    return Expanded(
                      child: ScrollablePositionedList.separated(
                        itemScrollController: itemScrollController,
                        itemCount:
                            (loadState as LoadSuccess).test.quizzes.length,
                        itemBuilder: (context, index) {
                          // build quiz
                          final quiz = loadState.test.quizzes[index];
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
                                  // build answers list
                                  ...List.generate(quiz.answers.length,
                                      (ansIndex) {
                                    final answer = quiz.answers[ansIndex];
                                    int idx = answerSheetState
                                        .map((e) => e.quizId)
                                        .toList()
                                        .indexOf(quiz.id);
                                    final isSelected =
                                        answer.id == answerSheetState[idx].id;
                                    return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        child: GestureDetector(
                                          onTap: () => context
                                              .read<RoomBloc>()
                                              .add(RoomUpdated(answer: answer)),
                                          child: Container(
                                            height: 56,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(16)),
                                                border: Border.all(
                                                    color: Color(
                                                        Palette.black.color),
                                                    width: 1.6)),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(8, 0, 16, 0),
                                                    child: Magicbox(
                                                      isActive: isSelected,
                                                      activeBgColor: Color(
                                                          Palette.black.color),
                                                      duration: 500,
                                                      child: Text(
                                                        answer.label,
                                                        style: TextStyle(
                                                            color: isSelected
                                                                ? Colors.white
                                                                : Color(Palette
                                                                    .black
                                                                    .color),
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            height: 1.4),
                                                      ),
                                                    )),
                                                Expanded(
                                                  child: Text(
                                                    answer.answer,
                                                    style: TextStyle(
                                                        color: Color(Palette
                                                            .black.color),
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        height: 1.4),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ));
                                  })
                                ],
                              ))
                            ],
                          );
                        },
                        separatorBuilder: (context, index) => const Divider(),
                      ),
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                case LoadFailure:
                  return const Text('failure');
                default:
                  return const Text('default');
              }
            })()
          ],
        ),
      )),
    );
  }
}
