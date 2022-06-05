import 'dart:math';

import 'package:chicken/common/common.dart';
import 'package:chicken/feature/splash/cubit/icon_cubit.dart';
import 'package:chicken/feature/splash/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RotateClover extends StatefulWidget {
  const RotateClover(
      {Key? key,
      required this.width,
      required this.height,
      required this.startDegree,
      required this.color,
      required this.index,
      required this.bgColor})
      : super(key: key);
  final double startDegree;
  final int index;
  final double width;
  final double height;
  final Color color;
  final Color bgColor;

  @override
  State<RotateClover> createState() => _RotateCloverState();
}

class _RotateCloverState extends State<RotateClover>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this,
        duration: Duration(
            milliseconds: Constant.SPLASH_CLOVER_DURATION.value.toInt()));
    _animation = Tween<double>(
            begin: widget.startDegree,
            end: widget.startDegree + Constant.SPALSH_CLOVER_ARC.value)
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
    return BlocConsumer<IconCubit, int>(
      listener: (context, state) {
        if (state == widget.index) {
          _controller.forward().whenComplete(() => Future.delayed(
              Duration(
                milliseconds: Constant.SPLASH_CLOVER_WAIT.value.toInt(),
              ),
              () => context.read<IconCubit>().increase()));
        }
      },
      buildWhen: (previous, current) =>
          current == widget.index || (widget.index == 4 && current == 5),
      builder: (context, state) {
        return state == widget.index
            ? AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Positioned(
                    right: widget.width / 2 * (1 - sin(_animation.value * pi / 180)),
                    top: widget.height / 2 * (1 - cos(_animation.value * pi / 180)),
                    child: CustomPaint(
                      size: Size(widget.width, widget.height),
                      painter: RotateLeaf(
                          R: Constant.SPLASH_CLOVER_R.value,
                          degree: _animation.value,
                          color: widget.color,
                          bgColor: widget.bgColor),
                    ),
                  );
                })
            : const SizedBox();
      },
    );
  }
}
