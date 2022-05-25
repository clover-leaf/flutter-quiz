import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chicken/domain/test_repository/test_repository.dart'
    show TestRepository;
import 'package:chicken/feature/room/room.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class RoomPage extends StatelessWidget {
  const RoomPage({Key? key, required this.parameters}) : super(key: key);

  final Map<String, String> parameters;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          RepositoryBloc(testRepository: context.read<TestRepository>())
            ..add(GetTest(parameters)),
      child: BlocConsumer<RepositoryBloc, RepositoryState>(
        listener: (context, state) {
          if (state is RepositoryError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.msg ?? 'error happen when fetching api'),
              ),
            );
          }
          print(state.runtimeType);
        },
        buildWhen: (previous, current) {
          return previous.runtimeType != current.runtimeType;
        },
        builder: (context, state) {
          if (state is RepositoryInitial) {
            return const LoadingPage();
          }
          if (state is RepositoryLoading) {
            return const LoadingPage();
          }
          if (state is RepositoryLoaded) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) =>
                      UtilBloc(answersheet: state.test.answers),
                ),
                BlocProvider(
                    create: (context) =>
                        TimerBloc()..add(TimerStart(state.test.duration))),
              ],
              child: RoomView(),
            );
          }
          if (state is RepositoryError) {
            return const ErrorPage();
          }
          return const NotFoundPage();
        },
      ),
    );
  }
}

class RoomView extends StatelessWidget {
  RoomView({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final ItemScrollController itemScrollController = ItemScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        endDrawer: Sidebox(
            numberOfQuiz:
                (context.read<RepositoryBloc>().state as RepositoryLoaded)
                    .test
                    .answers
                    .length,
            scaffoldKey: scaffoldKey),
        onEndDrawerChanged: (isOpen) {
          if (!isOpen && context.read<UtilBloc>().state.isScroll) {
            itemScrollController.scrollTo(
                index: context.read<UtilBloc>().state.tapIndex,
                duration: const Duration(milliseconds: 400));
          }
        },
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
          child: Column(
            children: [
              SizedBox(
                height: 48,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    // GestureDetector(
                    //   behavior: HitTestBehavior.opaque,
                    //   onTap: () => {print('exit')},
                    //   child: SizedBox(
                    //       height: 24,
                    //       width: 24,
                    //       child: Center(
                    //         child: Image.asset('assets/images/chevron.png'),
                    //       )),
                    // ),
                    Timerbox(),
                    // GestureDetector(
                    //   behavior: HitTestBehavior.opaque,
                    //   onTap: () => scaffoldKey.currentState?.openEndDrawer(),
                    //   child: SizedBox(
                    //       height: 24,
                    //       width: 24,
                    //       child: Center(
                    //         child: Image.asset('assets/images/list.png'),
                    //       )),
                    // ),
                  ],
                ),
              ),
              Expanded(
                child: ScrollablePositionedList.separated(
                  itemScrollController: itemScrollController,
                  itemCount:
                      (context.read<RepositoryBloc>().state as RepositoryLoaded)
                          .test
                          .answers
                          .length,
                  itemBuilder: (context, quizIndex) {
                    final quiz = (context.read<RepositoryBloc>().state
                            as RepositoryLoaded)
                        .test
                        .quizzes[quizIndex];
                    return Quizbox(quiz: quiz, quizIndex: quizIndex);
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 16,
                  ),
                ),
              )
            ],
          ),
        )));
  }
}
