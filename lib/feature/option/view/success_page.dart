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
          padding: const EdgeInsets.fromLTRB(32, 104, 32, 64),
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
            ],
          ),
        )));
  }
}

class DotIndicator extends StatelessWidget {
  const DotIndicator({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 2),
      child: BlocBuilder<UtilBloc, UtilState>(
        buildWhen: (previous, current) =>
            previous.seletecTab != current.seletecTab &&
            (previous.seletecTab == index || current.seletecTab == index),
        builder: (context, state) {
          final bool isActive = state.seletecTab == index;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            height: isActive
                ? Constant.OPTION_DOT_HEIGHT.value
                : Constant.OPTION_DOT_WIDTH.value,
            width: Constant.OPTION_DOT_WIDTH.value,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              color: isActive
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).primaryColor.withAlpha(193),
            ),
          );
        },
      ),
    );
  }
}

class FirstView extends StatelessWidget {
  const FirstView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        children: [
          Text(
            'Step 1: Choose quiz category',
            style: Theme.of(context).textTheme.headline1!.copyWith(
                  fontSize: 18,
                  
                ),
          )
        ],
      ),
      const SizedBox(
        height: 48,
      ),
      const CategoryOption(),
    ]);
  }
}

class SecondView extends StatelessWidget {
  const SecondView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        children: [
          Text(
            '2. Choose quiz difficulty and type',
            style: Theme.of(context).textTheme.headline1!.copyWith(
                  fontSize: 18,
                ),
          )
        ],
      ),
      const SizedBox(
        height: 48,
      ),
      const DifficultyOption(),
      SizedBox(
        height: Constant.PADDING.value,
      ),
      const TypeOption(),
    ]);
  }
}

class ThirdPage extends StatelessWidget {
  const ThirdPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        children: [
          Text(
            '3. Choose number of quiz and duration',
            style: Theme.of(context).textTheme.headline1!.copyWith(
                  fontSize: 18,
                ),
          )
        ],
      ),
      const SizedBox(
        height: 48,
      ),
      const AmountOption(),
      SizedBox(
        height: Constant.PADDING.value,
      ),
      const DurationOption(),
      const Spacer(),
      GestureDetector(
          onTap: () {
            UtilState _state = context.read<UtilBloc>().state;
            Map<String, Map<String, dynamic>> _parameters = {
              'category': _state.categoryList[_state.categoryIndex].toMap(),
              'difficulty':
                  _state.difficultyList[_state.difficultyIndex].toMap(),
              'type': _state.typeList[_state.typeIndex].toMap(),
              'amount': {'id': _state.amount.toString()},
              'duration': _state.duration.toMap()
            };
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => RoomPage(parameters: _parameters)));
          },
          child: const StartButton()),
    ]);
  }
}
