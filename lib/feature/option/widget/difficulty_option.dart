import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chicken/data/test_api/test_api.dart' show TestDifficulty;
import 'package:chicken/common/common.dart';
import 'package:chicken/feature/option/option.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DifficultyOption extends StatelessWidget {
  const DifficultyOption({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Difficulty: ',
              style: Theme.of(context).textTheme.headline1!.copyWith(
                  color: Theme.of(context).primaryColor.withAlpha(193)),
            ),
            BlocBuilder<UtilBloc, UtilState>(
              buildWhen: (previous, current) =>
                  previous.difficultyIndex != current.difficultyIndex,
              builder: (context, state) {
                return Text(
                  state.difficultyList[state.difficultyIndex].name,
                  style: Theme.of(context).textTheme.headline1,
                );
              },
            )
          ],
        ),
        SizedBox(
          height: Constant.PADDING.value,
        ),
        SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
                children: List.generate(
                    context.read<UtilBloc>().state.difficultyList.length,
                    (index) => DifficultBox(
                          difficulty: context
                              .read<UtilBloc>()
                              .state
                              .difficultyList[index],
                          index: index,
                        ))))
      ],
    );
  }
}

class DifficultBox extends StatelessWidget {
  const DifficultBox({
    super.key,
    required this.difficulty,
    required this.index,
  });

  final TestDifficulty difficulty;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<UtilBloc>().add(ChangeDifficulty(index)),
      child: SizedBox(
        height: Constant.OPTION_BOX_HEIGHT.value,
        width: Constant.OPTION_BOX_WIDTH.value,
        child: Column(children: [
          BlocBuilder<UtilBloc, UtilState>(
            buildWhen: (previous, current) {
              final prevIdx = previous.difficultyIndex;
              final curIdx = current.difficultyIndex;
              return (prevIdx != curIdx) &&
                  (index == prevIdx || index == curIdx);
            },
            builder: (context, state) {
              final isActive = index == state.difficultyIndex;
              return Container(
                  height: Constant.OPTION_BOX_DIAMETER.value,
                  width: Constant.OPTION_BOX_DIAMETER.value,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(
                          Constant.OPTION_BOX_DIAMETER.value / 2)),
                      border: Border.all(
                          color: Theme.of(context).primaryColor,
                          width: Constant.BORDER_WIDTH.value),
                      color: isActive
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).scaffoldBackgroundColor),
                  child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: SvgPicture.asset(difficulty.iconPath!,
                          height: Constant.OPTION_ICON_SIZE.value,
                          width: Constant.OPTION_ICON_SIZE.value,
                          color: isActive
                              ? Theme.of(context).scaffoldBackgroundColor
                              : Theme.of(context).primaryColor)));
            },
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            difficulty.name,
            style: Theme.of(context).textTheme.headline1,
            textAlign: TextAlign.center,
          ),
        ]),
      ),
    );
  }
}
