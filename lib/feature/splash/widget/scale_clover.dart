
import 'package:chicken/common/common.dart';
import 'package:chicken/feature/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScaleClover extends StatefulWidget {
  const ScaleClover(
      {Key? key,
      required this.width,
      required this.height,
      required this.color,
      required this.index,
      required this.bgColor})
      : super(key: key);
  final int index;
  final Color color;
  final Color bgColor;
  final double width;
  final double height;

  @override
  State<ScaleClover> createState() => _ScaleCloverState();
}

class _ScaleCloverState extends State<ScaleClover>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this,
        duration: Duration(
            milliseconds: Constant.SPLASH_CLOVER_DURATION.value.toInt()));
    _animation = Tween<double>(begin: 0, end: 1)
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
          return context.read<IconCubit>().state == widget.index
              ? Positioned(
                bottom: widget.height,
                  child: CustomPaint(
                    size: Size(widget.width* _animation.value, widget.height* _animation.value),
                    painter: ScaleLeaf(
                        R: Constant.SPLASH_CLOVER_R.value * _animation.value,
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
