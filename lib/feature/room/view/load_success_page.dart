import 'package:chicken/common/common.dart';
import 'package:chicken/feature/room/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: const SafeArea(child: Center(child: SuccessIcon())));
  }
}

class SuccessIcon extends StatefulWidget {
  const SuccessIcon({Key? key}) : super(key: key);

  @override
  State<SuccessIcon> createState() => _SuccessIconState();
}

class _SuccessIconState extends State<SuccessIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _animation = Tween<double>(begin: 0, end: 16).animate(_controller);
    _controller.forward().then((value) => Future.delayed(
        const Duration(milliseconds: 300),
        () => context.read<RepositoryBloc>().add(Show())));
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
        animation: _animation,
        builder: (context, child) {
          return SizedBox(
            height: 64,
            width: 64 + _animation.value * 8,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  border: Border.all(
                      color: Color(Palette.sapphire.color), width: 1.8),
                  color: Colors.white),
              child: Stack(
                alignment: Alignment.centerLeft,
                clipBehavior: Clip.antiAlias,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SvgPicture.asset(
                      'assets/images/checkmark.svg',
                      color: Color(Palette.sapphire.color),
                      height: 32,
                      width: 32,
                    ),
                  ),
                  Positioned(
                    left: 64,
                    child: Text(
                      'Success loading',
                      style: TextStyle(
                        color: Color(Palette.black.color),
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
