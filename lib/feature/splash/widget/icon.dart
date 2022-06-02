import 'dart:math';

import 'package:chicken/feature/splash/cubit/icon_cubit.dart';
import 'package:chicken/feature/splash/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Icon extends StatefulWidget {
  const Icon(
      {Key? key,
      required this.height,
      required this.width,
      required this.space,
      required this.R,
      required this.begin,
      required this.end,
      required this.color,
      required this.index,
      required this.duration,
      required this.delay})
      : super(key: key);
  final double height;
  final double width;
  final double space;
  final double R;
  final double begin;
  final double end;
  final int index;
  final int duration;
  final int delay;
  final Color color;

  @override
  State<Icon> createState() => _IconState();
}

class _IconState extends State<Icon> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: widget.duration));
    _animation = Tween<double>(begin: widget.begin, end: widget.end)
        .chain(CurveTween(curve: Curves.easeInSine))
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
                milliseconds: widget.delay,
              ),
              () => context.read<IconCubit>().increase()));
        }
      },
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return context.read<IconCubit>().state == widget.index
              ? Positioned(
                  right: (widget.width + widget.space) / 2 -
                      (widget.width + widget.space) /
                          2 *
                          sin(_animation.value * pi / 180),
                  top: (widget.height + widget.space) /
                      2 *
                      (1 - cos(_animation.value * pi / 180)),
                  child: CustomPaint(
                    size: Size(widget.width, widget.height),
                    painter: Leaf(
                        R: widget.R,
                        degree: _animation.value,
                        color: widget.color),
                  ),
                )
              : const SizedBox();
        },
      ),
    );
  }
}