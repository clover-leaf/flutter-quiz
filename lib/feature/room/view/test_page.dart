import 'package:chicken/common/common.dart';
import 'package:chicken/feature/room/room.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class TestPage extends StatelessWidget {
  const TestPage({Key? key, required ItemScrollController scrollController})
      : _scrollController = scrollController,
        super(key: key);
  final ItemScrollController _scrollController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SafeArea(
          child: Stack(
            clipBehavior: Clip.hardEdge,
            alignment: Alignment.topRight,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top,
                width: MediaQuery.of(context).size.width,
                child: RepaintBoundary(
                  child: ScrollablePositionedList.separated(
                    itemScrollController: _scrollController,
                    itemCount: (context.read<RepositoryBloc>().state
                            as RepositoryLoaded)
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
                      height: 8,
                    ),
                  ),
                ),
              ),
              BlocBuilder<UtilBloc, UtilState>(
                buildWhen: (previous, current) =>
                    previous.offsetDx != current.offsetDx ||
                    current.isCloseTab ||
                    current.isOpenTab,
                builder: (context, state) => AnimatedPositioned(
                  curve: (state.isOpenTab || state.isCloseTab)
                      ? Curves.easeInOut
                      : Curves.linear,
                  duration: (state.isOpenTab || state.isCloseTab)
                      ? const Duration(milliseconds: 200)
                      : const Duration(seconds: 0),
                  onEnd: () {
                    if (state.isOpenTab) {
                      context.read<UtilBloc>().add(OpenTabEnd());
                    } else {
                      context
                          .read<UtilBloc>()
                          .add(CloseTabEnd(controller: _scrollController));
                    }
                  },
                  right: state.offsetDx - Constant.SIDETAB_WIDTH.value,
                  child: Sidetab(
                      numberOfQuiz: (context.read<RepositoryBloc>().state
                              as RepositoryLoaded)
                          .test
                          .answers
                          .length),
                ),
              ),
              BlocBuilder<UtilBloc, UtilState>(
                buildWhen: (previous, current) =>
                    previous.offsetDx != current.offsetDx ||
                    previous.offsetDy != current.offsetDy ||
                    current.isCloseTab ||
                    current.isOpenTab,
                builder: (context, state) {
                  return AnimatedPositioned(
                      curve: (state.isOpenTab || state.isCloseTab)
                          ? Curves.easeInOut
                          : Curves.linear,
                      duration: (state.isOpenTab || state.isCloseTab)
                          ? Duration(
                              milliseconds:
                                  Constant.SIDETAB_TRANS_DURATION.value.toInt())
                          : const Duration(seconds: 0),
                      top: state.offsetDy,
                      right: state.offsetDx,
                      child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onPanUpdate: (detail) {
                            context.read<UtilBloc>().add(
                                MoveButton(detail.delta.dx, detail.delta.dy));
                          },
                          onPanEnd: (_) {
                            context.read<UtilBloc>().add(DragDxEnd());
                          },
                          onTap: () =>
                              context.read<UtilBloc>().add(ToggleTab()),
                          child: CustomPaint(
                            size: Size(Constant.SIDETAB_BUTTON_A.value,
                                Constant.SIDETAB_BUTTON_A.value * 2),
                            painter: Sidebutton(
                                a: Constant.SIDETAB_BUTTON_A.value,
                                r: Constant.SIDETAB_BUTTON_r.value,
                                R: Constant.SIDETAB_BUTTON_R.value,
                                primaryColor: Theme.of(context).primaryColor),
                          )));
                },
              ),
              // BlocBuilder<UtilBloc, UtilState>(
              //   buildWhen: (previous, current) =>
              //       previous.offsetDx != current.offsetDx ||
              //       previous.offsetDy != current.offsetDy ||
              //       current.isCloseTab ||
              //       current.isOpenTab,
              //   builder: (context, state) {
              //     return AnimatedPositioned(
              //         duration: (state.isOpenTab || state.isCloseTab)
              //             ? Duration(
              //                 milliseconds:
              //                     Constant.SIDETAB_TRANS_DURATION.value as int)
              //             : const Duration(seconds: 0),
              //         top: state.offsetDy + 34,
              //         right: state.offsetDx,
              //         child: SvgPicture.asset(
              //           'assets/images/arrow-left.svg',
              //           color: Theme.of(context).scaffoldBackgroundColor,
              //           width: 26,
              //           height: 26,
              //         ));
              //   },
              // ),
            ],
          ),
        ));
  }
}
