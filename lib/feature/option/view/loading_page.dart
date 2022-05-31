import 'package:chicken/common/common.dart';
import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(32, 32, 32, 16),
          child: Column(
            children: [
              Text('Do quiz',
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(fontSize: 24)),
              SizedBox(
                height: Constant.PADDING.value,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const StyleText(text: 'Difficulty'),
                  SizedBox(
                    height: Constant.PADDING.value,
                  ),
                  const BoxPlaceholder(),
                  SizedBox(
                    height: Constant.PADDING.value,
                  ),
                  const StyleText(text: 'Category'),
                  SizedBox(
                    height: Constant.PADDING.value,
                  ),
                  const BoxPlaceholder(),
                  SizedBox(
                    height: Constant.OPTION_BOX_PADDING.value,
                  ),
                  const BoxPlaceholder(),
                  SizedBox(
                    height: Constant.PADDING.value,
                  ),
                  const StyleText(text: 'Type'),
                  SizedBox(
                    height: Constant.PADDING.value,
                  ),
                  const BoxPlaceholder(),
                  SizedBox(
                    height: Constant.PADDING.value,
                  ),
                  const StyleText(text: 'Number of quiz'),
                  SizedBox(
                    height: Constant.PADDING.value,
                  ),
                  const StyleText(text: 'Test duration'),
                ],
              ),
              SizedBox(
                height: Constant.PADDING.value,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StyleText extends StatelessWidget {
  const StyleText({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context)
          .textTheme
          .headline1!
          .copyWith(color: Theme.of(context).primaryColor.withAlpha(193)),
    );
  }
}

class BoxPlaceholder extends StatelessWidget {
  const BoxPlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Constant.OPTION_BOX_DIAMETER.value,
      width: Constant.OPTION_BOX_WIDTH.value * 2 +
          Constant.OPTION_BOX_PADDING.value,
      decoration: BoxDecoration(
          borderRadius:
              BorderRadius.all(Radius.circular(Constant.BORDER_RADIUS.value)),
          color: Theme.of(context).primaryColor.withAlpha(66)),
    );
  }
}
