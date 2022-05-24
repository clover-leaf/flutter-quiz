import 'package:flutter/material.dart';

class Coolbox extends StatelessWidget {
  const Coolbox({
    super.key,
    this.height = 32,
    this.width = 32,
    this.borderRadius = 8,
    this.borderWidth = 1.6,
    this.text = '',
    this.textColor = Colors.white,
    this.bgColor = Colors.blue,
  });

  final double height, width, borderRadius, borderWidth;
  final String text;
  final Color textColor, bgColor;

  Coolbox copyWith(
      {int? height,
      width,
      borderRadius,
      borderWidth,
      String? text,
      Color? textColor,
      bgColor}) {
    return Coolbox(
      height: height?.toDouble() ?? this.height,
      width: width?.toDouble() ?? this.width,
      borderRadius: borderRadius?.toDouble() ?? this.borderRadius,
      borderWidth: borderWidth?.toDouble() ?? this.borderWidth,
      text: text ?? this.text,
      textColor: textColor ?? this.textColor,
      bgColor: bgColor ?? this.bgColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
              border: Border.all(color: Colors.black, width: borderWidth),
              color: Colors.transparent),
          child: Center(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 12,
                  color: textColor,
                  fontWeight: FontWeight.w700,
                  height: 1.4),
            ),
          ),
        ),
      ]),
    );
  }
}
