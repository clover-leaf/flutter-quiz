import 'dart:math';

import 'package:chicken/feature/splash/cubit/icon_cubit.dart';
import 'package:chicken/feature/splash/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double R = 24;
    const double space = 8;
    const int duration = 1000;
    const int delay = 100;
    final double sqrt2 = sqrt(2);
    final double height = R * (2 * sqrt2 + 1 - 1 / sqrt2);
    final double width = R * (2 + sqrt2);

    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              children: [
                SizedBox(
                  width: width * 2 + space,
                  height: height * 2 + space,
                  child: Stack(
                    alignment: AlignmentDirectional.topCenter,
                    children: [
                      Positioned(
                        top: 0,
                        child: CustomPaint(
                          size: Size(width, height),
                          painter: Leaf(
                              R: R, degree: 0, color: const Color(0xFF67BB4B)),
                        ),
                      ),
                      Clover(
                        height: height,
                        width: width,
                        space: space,
                        R: R,
                        begin: 0,
                        end: 90,
                        color: const Color(0xFF67BB4B),
                        duration: duration,
                        delay: delay,
                        index: 1,
                      ),
                      Clover(
                        height: height,
                        width: width,
                        space: space,
                        R: R,
                        begin: 90,
                        end: 180,
                        color: const Color(0xFF67BB4B),
                        duration: duration,
                        delay: delay,
                        index: 2,
                      ),
                      Clover(
                        height: height,
                        width: width,
                        space: space,
                        R: R,
                        begin: 180,
                        end: 270,
                        color: const Color(0xFF67BB4B),
                        duration: duration,
                        delay: delay,
                        index: 3,
                      ),
                  const SizedBox(
                    height: 32,
                  ),
                  const StartButton()
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class StartButton extends StatelessWidget {
  const StartButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<IconCubit>().increase(),
      child: Container(
        height: 64,
        width: 160,
        color: Colors.black,
      ),
    );
  }
}