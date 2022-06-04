import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:chicken/common/common.dart';

class Button extends StatelessWidget {
  const Button({Key? key, required this.label, required this.iconUrl})
      : super(key: key);
  final String label;
  final String iconUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Constant.RESULT_BUTTON_HEGHT.value,
      width: 120,
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.all(Radius.circular(Constant.BORDER_RADIUS.value)),
        color: Theme.of(context).primaryColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            iconUrl,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          const SizedBox(
            width: 8,
          ),
          Text(label, style: Theme.of(context).textTheme.headline2),
        ],
      ),
    );
  }
}
