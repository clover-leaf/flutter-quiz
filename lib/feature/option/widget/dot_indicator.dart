
import 'package:chicken/common/common.dart';
import 'package:chicken/feature/option/option.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            duration: const Duration(milliseconds: 400),
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