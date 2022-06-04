import 'dart:math';

import 'package:chicken/common/common.dart';
import 'package:chicken/feature/splash/cubit/icon_cubit.dart';
import 'package:chicken/feature/splash/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScaleLeaf extends StatefulWidget {
  const ScaleLeaf(
      {Key? key,
      required this.color,
      required this.index,
      required this.bgColor})
      : super(key: key);
  final int index;
  final Color color;
  final Color bgColor;

  @override
  State<ScaleLeaf> createState() => _ScaleLeafState();
}

class _ScaleLeafState extends State<ScaleLeaf>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this,
        duration: Duration(
            milliseconds: Constant.SPLASH_CLOVER_DURATION.value.toInt()));
    _animation = Tween<double>(begin: 0, end: Constant.SPLASH_CLOVER_R.value)
        .chain(CurveTween(curve: Curves.easeOutCubic))
        .animate(_controller);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<IconCubit, int>(
      listener: (context, state) {
        if (state == widget.index) {
          _controller.forward().whenComplete(() => Future.delayed(
              Duration(
                milliseconds: Constant.SPLASH_CLOVER_WAIT.value.toInt(),
              ),
              () => context.read<IconCubit>().increase()));
        }
      },
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final double height = _animation.value * (2 * sqrt2 + 1 - 1 / sqrt2);
          return context.read<IconCubit>().state == widget.index
              ? Positioned(
                  top: (Constant.SPLASH_CLOVER_R.value - _animation.value) *
                      (2 * sqrt2 + 1 - 1 / sqrt2),
                  child: CustomPaint(
                    size: Size(height, height),
                    painter: Leaf(
                        R: _animation.value,
                        degree: 0,
                        color: widget.color,
                        bgColor: widget.bgColor),
                  ),
                )
              : const SizedBox();
        },
      ),
    );
  }
}
