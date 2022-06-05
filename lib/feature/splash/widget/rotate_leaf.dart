import 'dart:math';
import 'dart:typed_data';

import 'package:chicken/common/common.dart';
import 'package:flutter/material.dart';

class RotateLeaf extends CustomPainter {
  final double degree;
  final Color color;
  final Color bgColor;
  final double R;
  RotateLeaf(
      {required this.degree,
      required this.color,
      required this.bgColor,
      required this.R});
  @override
  void paint(canvas, size) {
    final double scaleRatio = 1 + Constant.SPLASH_CLOVER_SPACE.value * sqrt2 / size.width;
    final Float64List scaleMatrix = Float64List.fromList([
      scaleRatio,
      0,
      0,
      0,
      0,
      scaleRatio,
      0,
      0,
      0,
      0,
      scaleRatio,
      0,
      0,
      0,
      0,
      1
    ]);

    final double toRadian = degree * pi / 180;
    final Float64List rotateMatrix = Float64List.fromList([
      cos(toRadian),
      sin(toRadian),
      0,
      0,
      -sin(toRadian),
      cos(toRadian),
      0,
      0,
      0,
      0,
      1,
      0,
      0,
      0,
      0,
      1
    ]);

    const Offset O = Offset(0, 0);
    final Offset A = Offset(-R * sqrt2, -R * sqrt2);
    final Offset B = Offset(0, -2 * sqrt2 * R);
    final Offset C = Offset(R * sqrt2, -R * sqrt2);

    final Path path = Path()
      ..moveTo(O.dx, O.dy)
      ..lineTo(A.dx, A.dy)
      ..arcToPoint(B, radius: Radius.circular(R))
      ..arcToPoint(C, radius: Radius.circular(R))
      ..lineTo(O.dx, O.dy);

    Path clover = path
        .shift(Offset(0, R * (2 * sqrt2 + 1 - 1 / sqrt2) / 2))
        .transform(rotateMatrix);

    final Path whiteOutline = clover
        .transform(scaleMatrix)
        .shift(Offset(size.width / 2, size.height / 2));

    clover = clover.shift(Offset(size.width / 2, size.height / 2));

    canvas.drawPath(whiteOutline, Paint()
      ..color = bgColor
      ..style = PaintingStyle.fill);

    canvas.drawPath(
        clover,
        Paint()
          ..color = color
          ..style = PaintingStyle.fill);
  }

  @override
  bool shouldRepaint(oldDelegate) {
    return false;
  }
}
