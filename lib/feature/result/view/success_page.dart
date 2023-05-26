// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chicken/common/common.dart';
import 'package:chicken/feature/result/result.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: WillPopScope(
            onWillPop: () async => false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(32, 64, 32, 16),
              child: BlocBuilder<ResultBloc, ResultState>(
                builder: (context, state) {
                  final ResultLoadSuccess _state = state as ResultLoadSuccess;
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 2 * Constant.RESULT_RADIUS.value,
                            width: 2 * Constant.RESULT_RADIUS.value,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    Constant.RESULT_RADIUS.value),
                                border: Border.all(
                                    color: Theme.of(context).primaryColor,
                                    width: 2 * Constant.BORDER_WIDTH.value)),
                            child: Center(
                              child: Text(
                                '${_state.getCorrectAnswer} / ${_state.test.answers.length}',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .copyWith(fontSize: 24),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Constant.PADDING.value,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: Constant.RESULT_COL_WIDTH.value,
                            padding: EdgeInsets.only(
                                left: Constant.RESULT_COL_LEFT_PADDING.value),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Tag(
                                  label: 'Category',
                                  value: _state.test.category.name,
                                ),
                                SizedBox(
                                  height: Constant.PADDING.value,
                                ),
                                Tag(
                                  label: 'Number of quiz',
                                  value: _state.test.answers.length.toString(),
                                ),
                                SizedBox(
                                  height: Constant.PADDING.value,
                                ),
                                Tag(
                                  label: 'Total time',
                                  value: _state.test.duration.getStylishTotal(),
                                )
                              ],
                            ),
                          ),
                          // SizedBox(width: Constant.PADDING.value,),
                          Container(
                            padding: EdgeInsets.only(
                                left: Constant.RESULT_COL_LEFT_PADDING.value),
                            width: Constant.RESULT_COL_WIDTH.value,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Tag(
                                  label: 'Difficulty',
                                  value: _state.test.difficulty.name,
                                ),
                                SizedBox(
                                  height: Constant.PADDING.value,
                                ),
                                Tag(
                                  label: 'Type',
                                  value: _state.test.type.name,
                                ),
                                SizedBox(
                                  height: Constant.PADDING.value,
                                ),
                                Tag(
                                  label: 'Used time',
                                  value: _state.test.duration.getStylishUsed(),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Buttonbox(
                        iconSvg: MyIcon.REVIEW.value,
                        label: 'Review answer',
                        width: 168,
                      ),
                      SizedBox(
                        height: Constant.PADDING.value,
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context).popUntil(ModalRoute.withName(PageName.OPTIONS.name)),
                        child: Buttonbox(
                          iconSvg: MyIcon.BACK.value,
                          label: 'Back to home',
                          width: 168,
                        ),
                      ),
                      SizedBox(
                        height: Constant.PADDING.value * 4,
                      ),
                    ],
                  );
                },
              ),
            )),
      ),
    );
  }
}
