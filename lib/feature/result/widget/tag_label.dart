
import 'package:flutter/material.dart';

class TagLabel extends StatelessWidget {
  const TagLabel({
    super.key,
    required this.tag,
    required this.content,
  });

  final String tag, content;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          tag,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 11,
              color: Colors.black,
              fontWeight: FontWeight.bold),
        ),
        Text(
          content,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
