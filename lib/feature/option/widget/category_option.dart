import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chicken/data/test_api/test_api.dart' show TestCategory;
import 'package:chicken/common/common.dart';
import 'package:chicken/feature/option/option.dart';
import 'package:flutter_svg/svg.dart';

class CategoryOption extends StatelessWidget {
  const CategoryOption({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int length = context.read<UtilBloc>().state.categoryList.length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Category: ',
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  color: Theme.of(context).primaryColor.withAlpha(193)),
            ),
            BlocBuilder<UtilBloc, UtilState>(
              buildWhen: (previous, current) =>
                  previous.categoryIndex != current.categoryIndex,
              builder: (context, state) {
                return Text(
                  state.categoryList[state.categoryIndex].name,
                  style: Theme.of(context).textTheme.displayLarge,
                );
              },
            )
          ],
        ),
        SizedBox(
          height: Constant.PADDING.value,
        ),
        SizedBox(
          height: Constant.OPTION_BOX_HEIGHT.value *
              (length / Constant.OPTION_COL_COUNT.value).ceil(),
          child: GridView.count(
            childAspectRatio: Constant.OPTION_BOX_WIDTH.value /
                Constant.OPTION_BOX_HEIGHT.value,
            crossAxisCount: 4,
            children: List.generate(
                length,
                (index) => CategoryBox(
                    category:
                        context.read<UtilBloc>().state.categoryList[index],
                    index: index)),
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
        child: Column(children: [
          BlocBuilder<UtilBloc, UtilState>(
            buildWhen: (previous, current) {
              final prevIdx = previous.categoryIndex;
              final curIdx = current.categoryIndex;
              return (prevIdx != curIdx) &&
                  (index == prevIdx || index == curIdx);
            },
            builder: (context, state) {
              final isActive = index == state.categoryIndex;
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
                      child: SvgPicture.asset(category.iconPath!,
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
            category.name,
            style: Theme.of(context).textTheme.displayLarge,
            textAlign: TextAlign.center,
          ),
        ]),
      ),
    );
  }
}
