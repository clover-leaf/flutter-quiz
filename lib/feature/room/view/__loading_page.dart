
import 'dart:math';

import 'package:chicken/common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
        body: SafeArea(
            child: Center(
      child: Container(
        height: 64,
        width: 64,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            border:
                Border.all(color: Color(Palette.sapphire.color), width: 1.8),
                color: Colors.white
            ),
        child: const LoadingIcon()
      ),
    )));
  }
}

class LoadingIcon extends StatefulWidget {
  const LoadingIcon({Key? key}) : super(key: key);

  @override
  State<LoadingIcon> createState() => _LoadingIconState();
}

class _LoadingIconState extends State<LoadingIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> animation;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    animation = Tween<double>(begin: 0, end: 360).animate(_controller);
    _controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animation,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: SvgPicture.asset(
            'assets/images/undo.svg',
            color: Color(Palette.sapphire.color),
            height: 32,
            width: 32,
          ),
        ),
        builder: (context, child) {
          return Transform.rotate(
            angle:  - animation.value * pi / 180,
            child: child,
          );
        });
  }
}
