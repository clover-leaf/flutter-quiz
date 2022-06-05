import 'dart:math';

import 'package:flutter/material.dart';

class ScaleLeaf extends CustomPainter {
  final Color color;
  final Color bgColor;
  final double R;
  ScaleLeaf({required this.color, required this.bgColor, required this.R});
  @override
  void paint(canvas, size) {
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
        .shift(Offset(size.width / 2, size.height / 2));

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
