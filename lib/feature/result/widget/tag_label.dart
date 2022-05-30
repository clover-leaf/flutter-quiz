
import 'package:flutter/material.dart';

class Tag extends StatelessWidget {
  const Tag({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: Theme.of(context).textTheme.headline1!.copyWith(
                color: Theme.of(context).primaryColor.withAlpha(193))),
        const SizedBox(
          height: 4,
        ),
        Text(value, style: Theme.of(context).textTheme.headline1)
      ],
    );
  }
}