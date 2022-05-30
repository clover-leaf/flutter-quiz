import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chicken/data/test_api/test_api.dart' show TestType;
import 'package:chicken/common/common.dart';
import 'package:chicken/feature/option/option.dart';

class TypeOption extends StatelessWidget {
  const TypeOption({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int len = context.read<UtilBloc>().state.typeList.length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Quiz type: ',
              style: Theme.of(context).textTheme.headline1!.copyWith(
                  color: Theme.of(context).primaryColor.withAlpha(193)),
            ),
            BlocBuilder<UtilBloc, UtilState>(
              buildWhen: (previous, current) =>
                  previous.typeIndex != current.typeIndex,
              builder: (context, state) {
                return Text(
                  state.typeList[state.typeIndex].name,
                  style: Theme.of(context).textTheme.headline1,
                );
              },
            )
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
              children: List.generate(
                  2 * len - 1,
                  (index) => index.isEven
                      ? GestureDetector(
                          onTap: () => context
                              .read<UtilBloc>()
                              .add(ChangeType(index ~/ 2)),
                          child: TypeBox(
                            type: context
                                .read<UtilBloc>()
                                .state
                                .typeList[index ~/ 2],
                            index: index ~/ 2,
                          ),
                        )
                      : const SizedBox(
                          width: 8,
                        ))),
        )
      ],
    );
  }
}

class TypeBox extends StatelessWidget {
  const TypeBox({
    super.key,
    required this.type,
    required this.index,
  });

  final TestType type;
  final int index;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Constant.OPTION_BOX_HEIGHT.value,
      width: Constant.OPTION_BOX_WIDTH.value,
      child: Stack(alignment: Alignment.bottomCenter, children: [
        BlocBuilder<UtilBloc, UtilState>(
          buildWhen: (previous, current) {
            final prevIdx = previous.typeIndex;
            final curIdx = current.typeIndex;
            return (prevIdx != curIdx) && (index == prevIdx || index == curIdx);
          },
          builder: (context, state) {
            final isActive = index == state.typeIndex;
            final double animatedHeight =
                isActive ? Constant.OPTION_BOX_HEIGHT.value - 4 : 0;
            return AnimatedContainer(
              curve: Curves.easeOutCubic,
              height: animatedHeight,
              width: Constant.OPTION_BOX_WIDTH.value +
                  2 *
                      animatedHeight *
                      Constant.BORDER_RADIUS.value /
                      (Constant.OPTION_BOX_HEIGHT.value - 4),
              duration: Duration(
                  milliseconds: Constant.OPTION_FILL_TRANS_DURATION.value.toInt()),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                      Radius.circular(Constant.BORDER_RADIUS.value)),
                  color: Theme.of(context).primaryColor),
            );
          },
        ),
        BlocBuilder<UtilBloc, UtilState>(
          buildWhen: (previous, current) {
            final prevIdx = previous.typeIndex;
            final curIdx = current.typeIndex;
            return (prevIdx != curIdx) && (index == prevIdx || index == curIdx);
          },
          builder: (context, state) {
            final isActive = index == state.typeIndex;
            return Center(
                child: AnimatedDefaultTextStyle(
              curve: Curves.easeOutCubic,
              duration: Duration(
                  milliseconds: Constant.OPTION_FILL_TRANS_DURATION.value.toInt()),
              style: Theme.of(context).textTheme.headline1!.copyWith(
                    color: isActive
                        ? Theme.of(context).scaffoldBackgroundColor
                        : Theme.of(context).primaryColor,
                  ),
              child: Text(type.name),
            ));
          },
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.all(Radius.circular(Constant.BORDER_RADIUS.value)),
            border: Border.all(
                color: Theme.of(context).primaryColor,
                width: Constant.BORDER_WIDTH.value),
          ),
        ),
      ]),
    );
  }
}
