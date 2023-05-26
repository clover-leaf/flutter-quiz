import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chicken/data/test_api/test_api.dart' show TestType;
import 'package:chicken/common/common.dart';
import 'package:chicken/feature/option/option.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  color: Theme.of(context).primaryColor.withAlpha(193)),
            ),
            BlocBuilder<UtilBloc, UtilState>(
              buildWhen: (previous, current) =>
                  previous.typeIndex != current.typeIndex,
              builder: (context, state) {
                return Text(
                  state.typeList[state.typeIndex].name,
                  style: Theme.of(context).textTheme.displayLarge,
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
                  len,
                  (index) => TypeBox(
                        type: context.read<UtilBloc>().state.typeList[index],
                        index: index,
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
    return GestureDetector(
      onTap: () => context.read<UtilBloc>().add(ChangeType(index)),
      child: SizedBox(
        height: Constant.OPTION_BOX_HEIGHT.value,
        width: Constant.OPTION_BOX_WIDTH.value - 8,
        child: Column(children: [
          BlocBuilder<UtilBloc, UtilState>(
            buildWhen: (previous, current) {
              final prevIdx = previous.typeIndex;
              final curIdx = current.typeIndex;
              return (prevIdx != curIdx) &&
                  (index == prevIdx || index == curIdx);
            },
            builder: (context, state) {
              final isActive = index == state.typeIndex;
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
                      child: SvgPicture.asset(type.iconPath!,
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
            type.name,
            style: Theme.of(context).textTheme.displayLarge,
            textAlign: TextAlign.center,
          ),
        ]),
      ),
    );
  }
}
