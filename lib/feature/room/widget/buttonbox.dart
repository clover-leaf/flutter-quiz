import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Buttonbox extends StatelessWidget {
  const Buttonbox({
    super.key,
    required this.iconSvg,
    required this.label,
    required this.borderRadius,
    required this.height,
    this.width,
  });

  final String iconSvg;
  final String label;
  final double borderRadius, height;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        width: width ?? double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
            color: Theme.of(context).scaffoldBackgroundColor),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 4, 0),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: SvgPicture.asset(
                  iconSvg,
                  height: height / 2,
                  width: height / 2,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            Text(label, style: Theme.of(context).textTheme.headline1),
          ],
        ));
  }
}
