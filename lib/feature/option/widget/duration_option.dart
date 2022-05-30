import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
              buildWhen: (previous, current) =>
                  previous != current,
              builder: (context, state) {
                return Text(
                  state.duration.toStylishString(),
                  style: Theme.of(context).textTheme.headline1,
                );
              },
            )
          ],
        ),
      ],
    );
  }
}
