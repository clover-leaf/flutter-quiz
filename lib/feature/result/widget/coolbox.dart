import 'package:flutter/material.dart';

class Coolbox extends StatelessWidget {
   const Coolbox({
    super.key,
    this.height = 32,
    this.width = 32,
    this.borderRadius = 8,
    this.borderWidth = 1.6,
    this.bgColor = Colors.blue,
    this.child = const SizedBox(),
  });

  final double height, width, borderRadius, borderWidth;
  final Widget child;
  final Color bgColor;

  Coolbox copyWith(
      {int? height,
      width,
      borderRadius,
      borderWidth,
      Widget? child,
      Color? textColor,
      bgColor}) {
    return Coolbox(
      height: height?.toDouble() ?? this.height,
      width: width?.toDouble() ?? this.width,
      borderRadius: borderRadius?.toDouble() ?? this.borderRadius,
      borderWidth: borderWidth?.toDouble() ?? this.borderWidth,
      bgColor: bgColor ?? this.bgColor,
      child: child ?? this.child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: height,
        width: width,
        child: Stack(alignment: Alignment.bottomCenter, children: [
          Container(
            height: height - 4,
            width: width,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                color: bgColor),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                border: Border.all(width: borderWidth),),
            child: Center(
              child: child
            ),
          ),
        ]),
      ),
    );
  }
}
