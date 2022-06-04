import 'package:chicken/common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chicken/data/test_api/test_api.dart' show TestDuration;
import 'package:chicken/feature/option/option.dart';

class DurationOption extends StatelessWidget {
  const DurationOption({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Test duration: ',
              style: Theme.of(context).textTheme.headline1!.copyWith(
                  color: Theme.of(context).primaryColor.withAlpha(193)),
            ),
            BlocBuilder<UtilBloc, UtilState>(
              buildWhen: (previous, current) => previous != current,
              builder: (context, state) {
                return Text(
                  state.duration.getStylishTotal(),
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
            physics: const NeverScrollableScrollPhysics(),
            child: Row(
                children: [1, 2, 5, 10]
                    .map((ele) => DurationBox(
                        duration: TestDuration.fromSecond(ele * 60)))
                    .toList()))
      ],
    );
  }
}

class DurationBox extends StatelessWidget {
  const DurationBox({
    super.key,
    required this.duration,
  });

  final TestDuration duration;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<UtilBloc>().add(ChangeDuration(duration)),
      child: SizedBox(
        height: Constant.OPTION_BOX_HEIGHT.value - 32,
        width: Constant.OPTION_BOX_WIDTH.value,
        child: Column(children: [
          BlocBuilder<UtilBloc, UtilState>(
            buildWhen: (previous, current) {
              final prev = previous.duration;
              final cur = current.duration;
              return (prev != cur) && (duration == prev || duration == cur);
            },
            builder: (context, state) {
              final isActive = duration == state.duration;
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
                child: Center(
                  child: Text((duration.total ~/ 60).toString(),
                      style: Theme.of(context).textTheme.headline1!.copyWith(
                          color: isActive
                              ? Theme.of(context).scaffoldBackgroundColor
                              : Theme.of(context).primaryColor,
                          fontSize: 15)),
                ),
              );
            },
          ),
        ]),
      ),
    );
  }
}
