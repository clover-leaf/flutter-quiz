import 'package:chicken/data/test_api/source/model/model.dart';
import 'package:chicken/feature/option/option.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OptionPage extends StatelessWidget {
  const OptionPage({Key? key, required this.optionList}) : super(key: key);

  final Map<String, List<Map<String, dynamic>>> optionList;

  @override
  Widget build(BuildContext context) {
    final List<TestCategory> categories =
        optionList['categories']!.map((e) => TestCategory.fromMap(e)).toList();
    final List<TestDifficulty> difficulties = optionList['difficulties']!
        .map((e) => TestDifficulty.fromMap(e))
        .toList();
    final List<TestType> types =
        optionList['types']!.map((e) => TestType.fromMap(e)).toList();

    return BlocProvider(
      create: (context) => UtilBloc(
          difficultyList: difficulties,
          categoryList: categories,
          typeList: types),
      child: const LoadSuccessPage(),
    );
  }
}

  // @override
  // Widget build(BuildContext context) {
  //   return BlocProvider(
  //     create: (_) =>
  //         RepositoryBloc(testRepository: context.read<TestRepository>())..add(GetCategoryList()),
  //     child: BlocBuilder<RepositoryBloc, RepositoryState>(
  //       builder: (context, state) {
  //         if (state is RepositoryInitial || state is RepositoryLoading) {
  //           return const LoadingPage();
  //         }
  //         if (state is RepositorySuccess) {
  //           return BlocProvider(
  //             create: (context) => UtilBloc(
  //                 difficultyList: state.difficultyList,
  //                 categoryList: state.categoryList,
  //                 typeList: state.typeList),
  //             child: const LoadSuccessPage(),
  //           );
  //         }
  //         if (state is RepositoryError) {
  //           return const ErrorPage();
  //         } else {
  //           return const ErrorPage();
  //         }
  //       },
  //     ),
  //   );
