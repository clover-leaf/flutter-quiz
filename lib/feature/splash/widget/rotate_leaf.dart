import 'dart:math';

import 'package:chicken/common/common.dart';
import 'package:chicken/feature/splash/cubit/icon_cubit.dart';
import 'package:chicken/feature/splash/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RotateLeaf extends StatefulWidget {
  const RotateLeaf(
      {Key? key,
      required this.startDegree,
      required this.color,
      required this.index,
      required this.bgColor})
      : super(key: key);
  final double startDegree;
  final int index;
  final Color color;
  final Color bgColor;

  @override
  State<RotateLeaf> createState() => _RotateLeafState();
}

class _RotateLeafState  extends State<RotateLeaf> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: Constant.SPLASH_CLOVER_DURATION.value.toInt()));
    _animation = Tween<double>(begin: widget.startDegree, end: widget.startDegree + Constant.SPALSH_CLOVER_ARC.value)
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
    final double height =
        Constant.SPLASH_CLOVER_R.value * (2 * sqrt2 + 1 - 1 / sqrt2);
    final double width = Constant.SPLASH_CLOVER_R.value * (2 + sqrt2);
    
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
          return context.read<IconCubit>().state == widget.index
              ? Positioned(
                  right: width / 2 -
                      width /
                          2 *
                          sin(_animation.value * pi / 180),
                  top: height/
                      2 *
                      (1 - cos(_animation.value * pi / 180)),
                  child: CustomPaint(
                    size: Size(width, height),
                    painter: Leaf(
                        R: Constant.SPLASH_CLOVER_R.value,
                        degree: _animation.value,
                        color: widget.color,
                        bgColor: widget.bgColor
                        ),
                  ),
                )
              : const SizedBox();
        },
      ),
    );
  }
}