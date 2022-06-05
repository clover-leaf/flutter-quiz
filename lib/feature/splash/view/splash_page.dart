import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chicken/app/cubit/theme_cubit.dart';
import 'package:chicken/common/common.dart';
import 'package:chicken/domain/test_repository/test_repository.dart'
    show TestRepository;
import 'package:chicken/feature/option/option.dart' show OptionPage;
import 'package:chicken/feature/splash/splash.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => IconCubit(),
        ),
        BlocProvider(
            create: (context) =>
                RepositoryCubit(testRepository: context.read<TestRepository>())
            ..getOption(),
            ),
      ],
      child: const SplashView(),
    );
  }
}

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height =
        Constant.SPLASH_CLOVER_R.value * (2 * sqrt2 + 1 - 1 / sqrt2) +
            Constant.SPLASH_CLOVER_SPACE.value * sqrt2;
    final double width = Constant.SPLASH_CLOVER_R.value * (2 + sqrt2) +
        Constant.SPLASH_CLOVER_SPACE.value * sqrt2;

    return MultiBlocListener(
      listeners: [
        BlocListener<ThemeCubit, ThemeState>(
          listener: (context, state) {
            if (state is ThemeLoaded) {
              Future.delayed(const Duration(microseconds: 1000),
                  () => context.read<IconCubit>().increase());
            }
          },
        ),
        BlocListener<IconCubit, int>(
          listener: (context, state) {
            if (state == Constant.SPALSH_CLOVER_ANIMATION.value &&
                context.read<RepositoryCubit>().state is RepositorySuccess) {
              final RepositorySuccess repoState =
                  context.read<RepositoryCubit>().state as RepositorySuccess;
              final Map<String, List<Map<String, dynamic>>> optionList = {
                'categories':
                    repoState.categoryList.map((e) => e.toMap()).toList(),
                'difficulties':
                    repoState.difficultyList.map((e) => e.toMap()).toList(),
                'types': repoState.typeList.map((e) => e.toMap()).toList(),
              };
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => OptionPage(
                            optionList: optionList,
                          )),
                  (route) => false);
            }
          },
        ),
        BlocListener<RepositoryCubit, RepositoryState>(
          listener: (context, state) {
            if (state is RepositoryError) {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const ErrorPage()),
                  (route) => false);
            } else if (state is RepositorySuccess &&
                context.read<IconCubit>().state ==
                    Constant.SPALSH_CLOVER_ANIMATION.value) {
              final Map<String, List<Map<String, dynamic>>> optionList = {
                'categories': state.categoryList.map((e) => e.toMap()).toList(),
                'difficulties':
                    state.difficultyList.map((e) => e.toMap()).toList(),
                'types': state.typeList.map((e) => e.toMap()).toList(),
              };
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => OptionPage(
                            optionList: optionList,
                          )),
                  (route) => false);
            }
          },
        ),
      ],
      child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: width * 2,
                        height: height * 2,
                        child: Stack(
                          alignment: AlignmentDirectional.topCenter,
                          children: [
                            ScaleClover(
                                width: width,
                                height: height,
                                color: Theme.of(context).primaryColor,
                                index: 1,
                                bgColor:
                                    Theme.of(context).scaffoldBackgroundColor),
                            ...List.generate(
                                3,
                                (index) => RotateClover(
                                    width: width,
                                    height: height,
                                    startDegree: 90.0 * index,
                                    color: Theme.of(context).primaryColor,
                                    index: index + 2,
                                    bgColor: Theme.of(context)
                                        .scaffoldBackgroundColor)),
                            LeakClover(
                                    width: width,
                                    height: height,
                                color: Theme.of(context).primaryColor,
                                index: 5,
                                bgColor:
                                    Theme.of(context).scaffoldBackgroundColor)
                          ],
                        ),
                      ),
                    ],
                  ),
                  AppTitle(
                    index: 5,
                    primary: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(
                    height: 64,
                  )
                ],
              ),
            ),
          )),
    );
  }
}
