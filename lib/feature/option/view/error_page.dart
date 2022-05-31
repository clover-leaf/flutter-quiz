import 'package:chicken/common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(32, 96, 32, 32),
            child: Column(
              children: [
                SvgPicture.asset(
                  MyIcon.ERROR.value,
                  height: 80,
                  width: 80,
                  // color: Theme.of(context).primaryColor
                ),
                const SizedBox(
                  height: 32,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Oh no!',
                      style: Theme.of(context).textTheme.headline1!.copyWith(
                          fontSize: 24, color: Theme.of(context).primaryColor),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 32,
                ),
                Text(
                  'No route was found  matching the URL.',
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                      color: Theme.of(context).primaryColor.withAlpha(193)),
                ),
              ],
            ),
          ),
        ));
  }
}
