import 'package:flutter/material.dart';

class Magicbox extends StatelessWidget {
  const Magicbox({
    super.key,
    this.height = 32,
    this.width = 32,
    this.borderRadius = 8,
    this.borderWidth = 1.6,
    this.activeBgColor = Colors.green,
    this.isActive = false,
    this.duration = 400,
    required this.child,
  });

  final double height, width, borderRadius, borderWidth;
  final Color activeBgColor;
  final bool isActive;
  final int duration;
  final Widget child;

  Magicbox copyWith({
    double? height,
    width,
    borderRadius,
    borderWidth,
    String? text,
    Color? activeBgColor,
    bool? isActive,
    int? duration,
    Widget? child,
  }) {
    return Magicbox(
      height: height ?? this.height,
      width: width ?? this.width,
      borderRadius: borderRadius ?? this.height,
      borderWidth: borderWidth ?? this.borderWidth,
      activeBgColor: activeBgColor ?? this.activeBgColor,
      isActive: isActive ?? this.isActive,
      duration: duration ?? this.duration,
      child: child ?? this.child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final double animatedHeight = isActive ? height - 4 : 0;
    return SizedBox(
      height: height,
      width: width,
      child: Stack(alignment: Alignment.bottomCenter, children: [
        AnimatedContainer(
          curve: Curves.easeInOutQuart,
          height: animatedHeight,
          width: animatedHeight < 16 ? animatedHeight + 8 : width,
          duration: Duration(milliseconds: duration),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              color: activeBgColor),
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
              border: Border.all(color: Colors.black, width: borderWidth),),
          child: Center(
            child: child,
          ),
        ),
      ]),
    );
  }
}
