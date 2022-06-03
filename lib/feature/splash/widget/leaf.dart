import 'dart:math';
import 'dart:typed_data';

import 'package:chicken/common/common.dart';
import 'package:flutter/material.dart';

class Leaf extends CustomPainter {
  final double degree;
  final Color color;
  final Color bgColor;

  Leaf({required this.degree, required this.color, required this.bgColor});
  @override
  void paint(canvas, size) {
    final painter = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;

    final double toRadian = degree * pi / 180;
    final double R = Constant.SPLASH_CLOVER_R.value;

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
    final center = path.shift(Offset(0, size.height / 2));
    final rotate = center.transform(Float64List.fromList([
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
    ]));
    final move = rotate.shift(Offset(size.width / 2, size.height / 2));
    canvas.drawPath(move, painter);
    canvas.drawPath(
        move,
        painter
          ..color = bgColor
          ..strokeWidth = Constant.SPLASH_CLOVER_SPACE.value
          ..style = PaintingStyle.stroke);
  }

  @override
  bool shouldRepaint(oldDelegate) {
    return false;
  }
}
