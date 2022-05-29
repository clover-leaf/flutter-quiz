import 'package:chicken/app/cubit/theme_cubit.dart';
import 'package:flutter/material.dart';

import 'package:chicken/feature/room/room.dart';
import 'package:chicken/common/common.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Sidetab extends StatelessWidget {
  const Sidetab({Key? key, required this.numberOfQuiz}) : super(key: key);

  final int numberOfQuiz;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height -
            MediaQuery.of(context).padding.top,
        width: Constant.SIDETAB_WIDTH.value,
        color: Theme.of(context).primaryColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Timerbox(),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 8),
                child: Text('Answer',
                    style: Theme.of(context).textTheme.headline2),
              ),
              SizedBox(
                height: (MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.top) *
                    3 /
                    5,
                child: GridView.count(
                  padding: EdgeInsets.zero,
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  children: [
                    ...List.generate(
                        numberOfQuiz, (index) => Icebox(quizIndex: index))
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Buttonbox(
                iconSvg: 'assets/images/submit.svg',
                label: 'Submit',
                height: 40,
                borderRadius: Constant.BORDER_RADIUS.value,
              ),
              const SizedBox(
                height: 16,
              ),
              Buttonbox(
                iconSvg: 'assets/images/logout.svg',
                label: 'Exit',
                height: 40,
                borderRadius: Constant.BORDER_RADIUS.value,
              ),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => context.read<ThemeCubit>().toggle(),
                      child: Theme.of(context).brightness == Brightness.light
                          ? const ThemeButton(
                              iconSvg: 'assets/images/light.svg',
                              themeMode: 'light')
                          : const ThemeButton(
                              iconSvg: 'assets/images/dark.svg',
                              themeMode: 'dark'))
                ],
              )),
              const SizedBox(
                height: 40,
              )
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (context) => ResultPage(
              //           parameters: loadState.test
              //               .copyWith(
              //                   answers: answersheet,
              //                   duration: testDurationState.duration)
              //               .toMap(),
              //         )));
              // context.read<TestDurationBloc>().close();
              // },
            ],
          ),
        ));
  }
}

class ThemeButton extends StatelessWidget {
  const ThemeButton({Key? key, required this.iconSvg, required this.themeMode})
      : super(key: key);

  final String iconSvg;
  final String themeMode;

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          iconSvg,
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(themeMode,
                style: Theme.of(context)
                    .textTheme
                    .headline2!
                    .copyWith(height: 0.9)),
            Text('mode',
                style: Theme.of(context)
                    .textTheme
                    .headline2!
                    .copyWith(height: 0.9)),
          ],
        )
      ],
    );
  }
}

class Timerbox extends StatelessWidget {
  const Timerbox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SvgPicture.asset(
          'assets/images/clock.svg',
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        const SizedBox(width: 8),
        BlocBuilder<TimerBloc, TimerState>(
          builder: (context, state) {
            String minute, second;
            if (state is TimerInitial) {
              minute = '00';
              second = '00';
            } else if (state is TimerRun) {
              final String remain = state.duration!.getRemainTime();
              minute = remain.substring(remain.length - 5, remain.length - 3);
              second = remain.substring(remain.length - 2);
            } else if (state is TimerComplete) {
              minute = '00';
              second = '00';
            } else {
              minute = '00';
              second = '00';
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('$minute min',
                    style: Theme.of(context)
                        .textTheme
                        .headline2!
                        .copyWith(height: 1)),
                Text('$second sec',
                    style: Theme.of(context)
                        .textTheme
                        .headline2!
                        .copyWith(height: 1)),
              ],
            );
          },
        )
      ],
    );

    Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        FittedBox(
          fit: BoxFit.scaleDown,
          child: SvgPicture.asset(
            'assets/images/clock.svg',
            height: 20,
            width: 20,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        BlocBuilder<TimerBloc, TimerState>(
          buildWhen: (previous, current) =>
              previous.runtimeType != current.runtimeType,
          builder: (context, state) {
            String time;
            if (state is TimerInitial) {
              time = '00:00:00';
            } else if (state is TimerRun) {
              time = state.duration!.getRemainTime();
            } else if (state is TimerComplete) {
              time = '00:00:00';
            } else {
              time = '00:00:00';
            }
            return Text(
              time,
              style: Theme.of(context).textTheme.headline2!.copyWith(height: 1),
            );
          },
        ),
      ],
    );
  }
}
