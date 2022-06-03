import 'package:chicken/app/cubit/theme_cubit.dart';
import 'package:chicken/common/common.dart';
import 'package:chicken/domain/test_repository/test_repository.dart';
import 'package:chicken/feature/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({Key? key, required this.testRepository}) : super(key: key);

  final TestRepository testRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: testRepository,
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
                theme: state.isDark ? AppTheme.dark : AppTheme.light,
                debugShowCheckedModeBanner: false,
                home: const SplashPage()
              );
        },
      ),
    );
  }
}
