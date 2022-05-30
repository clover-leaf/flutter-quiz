import 'package:chicken/common/common.dart';
import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 16,
                ),
                ...List.generate(4, (_) {
                  return const QuizPlaceholder();
                })
              ],
            ),
          ),
        ));
  }
}

class AnswerPlaceholder extends StatelessWidget {
  const AnswerPlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        children: const [
          Placeholder(
            height: 32,
            width: 32,
          ),
          SizedBox(
            width: 16,
          ),
          Expanded(child: Placeholder(height: 32)),
        ],
      ),
    );
  }
}

class QuizPlaceholder extends StatelessWidget {
  const QuizPlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(56, 0, 32, 24),
      child: Column(
        children: [
          const Placeholder(height: 48),
          const SizedBox(
            height: 16,
          ),
          ...List.generate(4, (_) => const AnswerPlaceholder()),
          const SizedBox(
            height: 8,
          )
        ],
      ),
    );
  }
}

class Placeholder extends StatelessWidget {
  const Placeholder(
      {Key? key, required this.height, this.width = double.infinity})
      : super(key: key);

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          borderRadius:
              BorderRadius.all(Radius.circular(Constant.BORDER_RADIUS.value)),
          color: Theme.of(context).primaryColor.withAlpha(66)),
    );
  }
}
