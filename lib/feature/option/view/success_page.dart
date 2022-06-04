// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:chicken/common/common.dart';
import 'package:chicken/feature/option/option.dart';
import 'package:chicken/feature/room/room.dart' show RoomPage;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoadSuccessPage extends StatelessWidget {
  const LoadSuccessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const List<Widget> viewList = [FirstView(), SecondView(), ThirdPage()];
    PageController _pageController = PageController(initialPage: 0);
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.fromLTRB(32, 48, 32, 48),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  controller: _pageController,
                  onPageChanged: (index) =>
                      context.read<UtilBloc>().add(ChangeTab(index)),
                  itemCount: viewList.length,
                  itemBuilder: (context, index) => viewList[index],
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    height: Constant.OPTION_DOT_HEIGHT.value,
                    child: Row(
                      children: List.generate(
                          viewList.length,
                          ((index) => DotIndicator(
                                index: index,
                              ))),
                    ),
                  ),
                  const Spacer(),
                  BlocBuilder<UtilBloc, UtilState>(
                    buildWhen: (previous, current) =>
                        previous.seletecTab != current.seletecTab,
                    builder: (context, state) {
                      if (state.seletecTab == 2) {
                        return GestureDetector(
                            onTap: () {
                              UtilState _state = context.read<UtilBloc>().state;
                              Map<String, Map<String, dynamic>> _parameters = {
                                'category': _state
                                    .categoryList[_state.categoryIndex]
                                    .toMap(),
                                'difficulty': _state
                                    .difficultyList[_state.difficultyIndex]
                                    .toMap(),
                                'type':
                                    _state.typeList[_state.typeIndex].toMap(),
                                'amount': {'id': _state.amount.toString()},
                                'duration': _state.duration.toMap()
                              };
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      RoomPage(parameters: _parameters)));
                              _pageController.jumpTo(0);
                            },
                            child: Button(
                              label: 'Start',
                              iconUrl: MyIcon.START.value,
                            ));
                      } else {
                        return GestureDetector(
                            onTap: () => _pageController.animateToPage(
                                state.seletecTab + 1,
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.easeOutCubic),
                            child: Button(
                              label: 'Next',
                              iconUrl: MyIcon.NEXT.value,
                            ));
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        )));
  }
}
