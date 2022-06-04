import 'package:chicken/common/common.dart';
import 'package:chicken/feature/splash/cubit/icon_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppTitle extends StatefulWidget {
  const AppTitle({Key? key, required this.index, required this.primary})
      : super(key: key);
  final int index;
  final Color primary;

  @override
  State<AppTitle> createState() => _AppTitleState();
}

class _AppTitleState extends State<AppTitle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this,
        duration: Duration(
            milliseconds: 2 * Constant.SPLASH_CLOVER_DURATION.value.toInt()));
    _animation = Tween<double>(begin: 0, end: 48)
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
      child: SizedBox(
        height: 48,
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return context.read<IconCubit>().state == widget.index
                ? Padding(
                    padding: EdgeInsets.only(top: 48 - _animation.value),
                    child: Text(
                      'Clover',
                      style: Theme.of(context)
                          .textTheme
                          .headline1!
                          .copyWith(fontSize: 32, color: widget.primary),
                    ),
                  )
                : const SizedBox();
          },
        ),
      ),
    );
  }
}
