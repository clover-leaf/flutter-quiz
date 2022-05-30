import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chicken/data/test_api/test_api.dart' show TestCategory;
import 'package:chicken/common/common.dart';
import 'package:chicken/feature/option/option.dart';

class CategoryOption extends StatelessWidget {
  const CategoryOption({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int len = context.read<UtilBloc>().state.categoryList.length;
    final int rows = Constant.OPTION_ROW_COUNT.value.toInt();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Category: ',
              style: Theme.of(context).textTheme.headline1!.copyWith(
                  color: Theme.of(context).primaryColor.withAlpha(193)),
            ),
            BlocBuilder<UtilBloc, UtilState>(
              buildWhen: (previous, current) =>
                  previous.categoryIndex != current.categoryIndex,
              builder: (context, state) {
                return Text(
                  state.categoryList[state.categoryIndex].name,
                  style: Theme.of(context).textTheme.headline1,
                );
              },
            )
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        SizedBox(
          height: Constant.OPTION_BOX_HEIGHT.value * rows +
              Constant.OPTION_BOX_PADDING.value * (rows - 1),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: len ~/ rows,
            separatorBuilder: (context, index) => const SizedBox(width: 8),
            itemBuilder: (context, colIndex) {
              return Column(
                children: List.generate(
                  2 * rows - 1,
                  (rowIndex) => rowIndex.isEven
                      ? CategoryBox(
                          category: context.read<UtilBloc>().state.categoryList[
                              (colIndex * rows + rowIndex ~/ 2).toInt()],
                          index: (colIndex * rows + rowIndex ~/ 2).toInt(),
                        )
                      : const SizedBox(
                          height: 8,
                        ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class CategoryBox extends StatelessWidget {
  const CategoryBox({
    super.key,
    required this.category,
    required this.index,
  });

  final TestCategory category;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<UtilBloc>().add(ChangeCategory(index)),
      child: SizedBox(
        height: Constant.OPTION_BOX_HEIGHT.value,
        width: Constant.OPTION_BOX_WIDTH.value,
        child: Stack(alignment: Alignment.bottomCenter, children: [
          BlocBuilder<UtilBloc, UtilState>(
            buildWhen: (previous, current) {
              final prevIdx = previous.categoryIndex;
              final curIdx = current.categoryIndex;
              return (prevIdx != curIdx) &&
                  (index == prevIdx || index == curIdx);
            },
            builder: (context, state) {
              final isActive = index == state.categoryIndex;
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
                    milliseconds:
                        Constant.OPTION_FILL_TRANS_DURATION.value.toInt()),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                        Radius.circular(Constant.BORDER_RADIUS.value)),
                    color: Theme.of(context).primaryColor),
              );
            },
          ),
          BlocBuilder<UtilBloc, UtilState>(
            buildWhen: (previous, current) {
              final prevIdx = previous.categoryIndex;
              final curIdx = current.categoryIndex;
              return (prevIdx != curIdx) &&
                  (index == prevIdx || index == curIdx);
            },
            builder: (context, state) {
              final isActive = index == state.categoryIndex;
              return SizedBox(
                width: Constant.OPTION_BOX_WIDTH.value - 40,
                child: Center(
                  child: AnimatedDefaultTextStyle(
                    curve: Curves.easeOutCubic,
                    duration: Duration(
                        milliseconds:
                            Constant.OPTION_FILL_TRANS_DURATION.value.toInt()),
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                          height: 1.6,
                          color: isActive
                              ? Theme.of(context).scaffoldBackgroundColor
                              : Theme.of(context).primaryColor,
                        ),
                    textAlign: TextAlign.center,
                    child: Text(category.name),
                  ),
                ),
              );
            },
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                  Radius.circular(Constant.BORDER_RADIUS.value)),
              border: Border.all(
                  color: Theme.of(context).primaryColor,
                  width: Constant.BORDER_WIDTH.value),
            ),
          ),
        ]),
      ),
    );
  }
}
