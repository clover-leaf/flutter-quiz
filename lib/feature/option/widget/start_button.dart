import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:chicken/common/common.dart';

class StartButton extends StatelessWidget {
  const StartButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Constant.OPTION_BOX_HEIGHT.value,
      width: Constant.OPTION_BOX_WIDTH.value - 24,
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.all(Radius.circular(Constant.BORDER_RADIUS.value)),
        color: Theme.of(context).primaryColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            MyIcon.START.value,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          const SizedBox(width: 8,),
          Text('Start', style: Theme.of(context).textTheme.headline2),
        ],
      ),
    );
  }
}
