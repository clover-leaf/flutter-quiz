import 'package:chicken/common/common.dart';
import 'package:chicken/feature/room/room.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class TestPage extends StatelessWidget {
  TestPage({Key? key}) : super(key: key);

  final ItemScrollController scrollController = ItemScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: WillPopScope(
          onWillPop: () async {
            final bool value = await showDialog<bool>(
                    context: context,
                    builder: (context) => const ConfirmDialog()) ??
                true;
            return value;
          },
          child: SafeArea(
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
                      itemScrollController: scrollController,
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
                      previous.offsetDx != current.offsetDx &&
                      (current.offsetDx == Constant.SIDETAB_WIDTH.value ||
                          previous.offsetDx == Constant.SIDETAB_WIDTH.value),
                  builder: (context, state) {
                    if (state.isOpenTab) {
                      return GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => context.read<UtilBloc>().add(ToggleTab()),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          color: Theme.of(context).primaryColor.withAlpha(106),
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
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
                            .add(CloseTabEnd(controller: scrollController));
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
                                milliseconds: Constant
                                    .SIDETAB_TRANS_DURATION.value
                                    .toInt())
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
              ],
            ),
          ),
        ));
  }
}
