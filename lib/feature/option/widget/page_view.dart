

import 'package:chicken/common/common.dart';
import 'package:chicken/feature/option/option.dart';
import 'package:flutter/material.dart';

class FirstView extends StatelessWidget {
  const FirstView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        'Step 1',
        style: Theme.of(context).textTheme.headline1!.copyWith(
            fontSize: 16,
            color: Theme.of(context).primaryColor.withAlpha(193),
            fontWeight: FontWeight.normal),
      ),
      Text(
        'Choose category of quizzes',
        style: Theme.of(context).textTheme.headline1!.copyWith(
              fontSize: 22,
            ),
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
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        'Step 2',
        style: Theme.of(context).textTheme.headline1!.copyWith(
            fontSize: 16,
            color: Theme.of(context).primaryColor.withAlpha(193),
            fontWeight: FontWeight.normal),
      ),
      Text(
        'Choose difficulty & quiz type',
        style: Theme.of(context).textTheme.headline1!.copyWith(
              fontSize: 22,
            ),
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
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        'Step 3',
        style: Theme.of(context).textTheme.headline1!.copyWith(
            fontSize: 16,
            color: Theme.of(context).primaryColor.withAlpha(193),
            fontWeight: FontWeight.normal),
      ),
      Text(
        'Choose number of quiz & duration',
        style: Theme.of(context).textTheme.headline1!.copyWith(
              fontSize: 22,
            ),
      ),
      const SizedBox(
        height: 48,
      ),
      const AmountOption(),
      SizedBox(
        height: Constant.PADDING.value,
      ),
      const DurationOption(),
    ]);
  }
}
