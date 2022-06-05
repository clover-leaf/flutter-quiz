// ignore_for_file: non_constant_identifier_names, no_leading_underscores_for_local_identifiers

import 'dart:math';
import 'dart:typed_data';

import 'package:chicken/common/common.dart';
import 'package:flutter/material.dart';

class LeakLeaf extends CustomPainter {
  final double degree;
  final Color color;
  final Color bgColor;
  final double R;
  final double alpha;
  LeakLeaf(
      {required this.degree,
      required this.alpha,
      required this.color,
      required this.bgColor,
      required this.R});

  @override
  void paint(canvas, size) {
    final double toRadian = degree * pi / 180;
    const double scaleRatio = 0.96;
    final Float64List scale_matrix = Float64List.fromList([
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
    final Float64List rotate_matrix = Float64List.fromList([
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
    final Offset X = Offset(R * (1 + 1 / sqrt2), -R * 3 / sqrt2);

    final Path path = Path()
      ..moveTo(O.dx, O.dy)
      ..lineTo(A.dx, A.dy)
      ..arcToPoint(B, radius: Radius.circular(R))
      ..arcToPoint(C, radius: Radius.circular(R))
      ..lineTo(O.dx, O.dy);

    final outside_path = path
        .shift(Offset(0, R * (2 * sqrt2 + 1 - 1 / sqrt2) / 2))
        .transform(rotate_matrix)
        .transform(scale_matrix)
        .shift(Offset(size.width / 2, size.height / 2));

    canvas.drawPath(outside_path, Paint()
      ..color = color.withAlpha(193)
      ..strokeCap = StrokeCap.round
      ..strokeWidth = Constant.SPALASH_CLOVER_BORDER_WIDTH.value
      ..style = PaintingStyle.stroke);

    final Path awesomePath = Path();
    if (X.dx - alpha >= C.dx) {
      awesomePath
        ..moveTo(O.dx, O.dy)
        ..lineTo(A.dx, A.dy)
        ..arcToPoint(B, radius: Radius.circular(R))
        ..arcToPoint(
            Offset(X.dx - alpha,
                -sqrt(2 * R * alpha - alpha * alpha) - R * 3 / sqrt2),
            radius: Radius.circular(R))
        ..lineTo(
            X.dx - alpha, sqrt(2 * R * alpha - alpha * alpha) - R * 3 / sqrt2)
        ..arcToPoint(C, radius: Radius.circular(R))
        ..lineTo(O.dx, O.dy);
    } else if (X.dx - alpha >= 0) {
      awesomePath
        ..moveTo(O.dx, O.dy)
        ..lineTo(A.dx, A.dy)
        ..arcToPoint(B, radius: Radius.circular(R))
        ..arcToPoint(
            Offset(X.dx - alpha,
                -sqrt(2 * R * alpha - alpha * alpha) - R * 3 / sqrt2),
            radius: Radius.circular(R))
        ..lineTo(X.dx - alpha, -X.dx + alpha)
        ..lineTo(O.dx, O.dy);
    } else if (X.dx - alpha >= A.dx) {
      final double _alpha = 2 * X.dx - alpha;
      awesomePath
        ..moveTo(_alpha - X.dx, _alpha - X.dx)
        ..lineTo(_alpha - X.dx,
            -sqrt(2 * R * _alpha - _alpha * _alpha) - R * 3 / sqrt2)
        ..arcToPoint(A, radius: Radius.circular(R), clockwise: false)
        ..lineTo(_alpha - X.dx, _alpha - X.dx);
    } else {
      final double _alpha = alpha - X.dx;
      awesomePath
        ..moveTo(_alpha - X.dx,
            -sqrt(2 * R * _alpha - _alpha * alpha) - R * 3 / sqrt2)
        ..lineTo(_alpha - X.dx,
            sqrt(2 * R * _alpha - _alpha * _alpha) - R * 3 / sqrt2)
        ..arcToPoint(
            Offset(_alpha - X.dx,
                -sqrt(2 * R * _alpha - _alpha * _alpha) - R * 3 / sqrt2),
            radius: Radius.circular(R));
    }
    final fill_path = awesomePath
        .shift(Offset(0, R * (2 * sqrt2 + 1 - 1 / sqrt2) / 2))
        .transform(rotate_matrix)
        .shift(Offset(size.width / 2, size.height / 2));
    canvas.drawPath(fill_path, Paint()
      ..color = color
      ..style = PaintingStyle.fill);
  }

  @override
  bool shouldRepaint(oldDelegate) {
    return true;
  }
}
