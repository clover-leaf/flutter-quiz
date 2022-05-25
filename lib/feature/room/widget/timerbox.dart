import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chicken/common/common.dart';
import 'package:chicken/feature/room/room.dart';

class Timerbox extends StatelessWidget {
  const Timerbox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
        buildWhen: (previous, current) =>
            previous.runtimeType != current.runtimeType,
        builder: (context, state) {
          if (state is TimerInitial) {
            return const BlankTimerbox();
          } else if (state is TimerRun) {
            return const RunTimerbox();
          } else if (state is TimerComplete) {
            return const CompleteTimerbox();
          } else {
            return const BlankTimerbox();
          }
        },
      );
  }
}

class RunTimerbox extends StatelessWidget {
  const RunTimerbox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      width: 64,
      child: Stack(alignment: Alignment.bottomCenter, children: [
        Container(
          height: 28,
          decoration: BoxDecoration(
            color: Color(Palette.sapphire.color),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
        ),
        Container(
          height: 32,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            border: Border.all(width: 1.6, color: Color(Palette.black.color)),
          ),
        ),
        Center(
          child: RepaintBoundary(
            child: BlocBuilder<TimerBloc, TimerState>(
              builder: (context, state) {
                return Text(state.duration!.getRemainTime(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ));
              },
            ),
          ),
        ),
      ]),
    );
  }
}

class BlankTimerbox extends StatelessWidget {
  const BlankTimerbox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      width: 64,
      child: Container(
        decoration: BoxDecoration(
            color: Color(Palette.sky.color),
            borderRadius: const BorderRadius.all(Radius.circular(8))),
      ),
    );
  }
}

class CompleteTimerbox extends StatelessWidget {
  const CompleteTimerbox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      width: 64,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            border: Border.all(color: Color(Palette.black.color), width: 1.6)),
        child: Center(
          child: Text('00:00',
              style: TextStyle(
                color: Color(Palette.black.color),
                fontSize: 12,
                fontWeight: FontWeight.bold,
              )),
        ),
      ),
    );
  }
}
