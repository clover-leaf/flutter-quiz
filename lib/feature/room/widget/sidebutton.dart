// ignore_for_file: non_constant_identifier_names

import 'dart:math';

import 'package:flutter/material.dart';

class Sidebutton extends CustomPainter {
  Sidebutton({
    required this.primaryColor,
    required this.a,
    required this.R,
    required this.r,
  });

  final double a, R, r;
  final Color primaryColor;
  final double sqrt2 = sqrt(2);

  @override
  void paint(canvas, size) {
    // Offset X1 = Offset(r * sqrt2, a + R);
    final Offset A1 = Offset(r / sqrt2, r / sqrt2 + a);
    final Offset A2 = Offset(r / sqrt2, -r / sqrt2 + a);

    // final Offset X2 = Offset(a - R, R * (2 - sqrt2));
    final Offset B1 = Offset(a - R * (1 - 1 / sqrt2), R * (1 - 1 / sqrt2));
    final Offset B2 = Offset(a, R * (1 - sqrt2));

    // final Offset X3 = Offset(a - R, 2 * a + R * sqrt2);
    final Offset C1 = Offset(a - R * (1 - 1 / sqrt2), 2 * a + R / sqrt2 - R);
    final Offset C2 = Offset(a, 2 * a + R * sqrt2 - R);

    final Offset D1 = C2.translate(8, 0);
    final Offset D2 = B2.translate(8, 0);

    final Path path = Path()
      ..moveTo(B2.dx, B2.dy)
      ..arcToPoint(B1, radius: Radius.circular(r))
      ..lineTo(A2.dx, A2.dy)
      ..arcToPoint(A1, radius: Radius.circular(r), clockwise: false)
      ..lineTo(A1.dx, A1.dy)
      ..lineTo(C1.dx, C1.dy)
      ..arcToPoint(C2, radius: Radius.circular(R))
      ..lineTo(C2.dx, C2.dy)
      ..lineTo(D1.dx, D1.dy)
      ..lineTo(D2.dx, D2.dy);

    final painter = Paint()
      ..color = primaryColor
      ..strokeWidth = 1.6
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, painter);
  }

  @override
  bool shouldRepaint(oldDelegate) {
    return false;
  }
}
