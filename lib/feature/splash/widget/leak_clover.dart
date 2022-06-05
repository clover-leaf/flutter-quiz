import 'dart:math';

import 'package:chicken/common/common.dart';
import 'package:chicken/feature/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LeakClover extends StatefulWidget {
  const LeakClover(
      {Key? key,
      required this.width,
      required this.height,
      required this.color,
      required this.index,
      required this.bgColor})
      : super(key: key);
  final double width;
  final double height;
  final int index;
  final Color color;
  final Color bgColor;

  @override
  State<LeakClover> createState() => _LeakCloverState();
}

class _LeakCloverState extends State<LeakClover>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this,
        duration: Duration(
            milliseconds: 2 * Constant.SPLASH_CLOVER_DURATION.value.toInt()));
    _animation = Tween<double>(
            begin: 0, end: 2 * Constant.SPLASH_CLOVER_R.value * (1 + 1 / sqrt2))
        .chain(CurveTween(curve: Curves.linear))
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
          _controller.forward();
        }
      },
      buildWhen: (previous, current) => current == widget.index ,
      builder: (context, state) {
        return AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return state == widget.index
                ? Positioned(
                    top: widget.height / 2,
                    left: 0,
                    child: CustomPaint(
                      size: Size(widget.width, widget.height),
                      painter: LeakLeaf(
                          alpha: _animation.value,
                          R: Constant.SPLASH_CLOVER_R.value,
                          degree: 270,
                          color: widget.color,
                          bgColor: widget.bgColor),
                    ),
                  )
                : const SizedBox();
          },
        );
      },
    );
  }
}
