import 'dart:math';

import 'package:chicken/common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chicken/feature/option/option.dart';

class AmountOption extends StatelessWidget {
  const AmountOption({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Number of quiz: ',
              style: Theme.of(context).textTheme.headline1!.copyWith(
                  color: Theme.of(context).primaryColor.withAlpha(193)),
            ),
            BlocBuilder<UtilBloc, UtilState>(
              buildWhen: (previous, current) => previous != current,
              builder: (context, state) {
                return Text(
                  '${state.amount} quizzes',
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
                children: List.generate(
                    4,
                    (index) => AmountBox(
                          amount: index == 0 ? 10  : 25 * pow(2, index - 1).toInt(),
                        ))))
      ],
    );
  }
}

class AmountBox extends StatelessWidget {
  const AmountBox({
    super.key,
    required this.amount,
  });

  final int amount;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<UtilBloc>().add(ChangeAmount(amount)),
      child: SizedBox(
        height: Constant.OPTION_BOX_HEIGHT.value - 32,
        width: Constant.OPTION_BOX_WIDTH.value,
        child: Column(children: [
          BlocBuilder<UtilBloc, UtilState>(
            buildWhen: (previous, current) {
              final prev = previous.amount;
              final cur = current.amount;
              return (prev != cur) && (amount == prev || amount == cur);
            },
            builder: (context, state) {
              final isActive = amount == state.amount;
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
                  child: Text(
                    amount.toString(),
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                      color: isActive ? Theme.of(context).scaffoldBackgroundColor : 
                      Theme.of(context).primaryColor,
                      fontSize: 15
                    )
                  ),
                ),
              );
            },
          ),
        ]),
      ),
    );
  }
}
