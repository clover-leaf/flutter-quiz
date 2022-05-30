import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chicken/feature/option/option.dart';
import 'package:chicken/domain/test_repository/source/test_repository.dart'
    show TestRepository;

class OptionPage extends StatelessWidget {
  const OptionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          RepositoryBloc(testRepository: context.read<TestRepository>())..add(GetCategoryList()),
      child: BlocBuilder<RepositoryBloc, RepositoryState>(
        builder: (context, state) {
          if (state is RepositoryInitial || state is RepositoryLoading) {
            return const LoadingPage();
          }
          if (state is RepositorySuccess) {
            return BlocProvider(
              create: (context) => UtilBloc(
                  difficultyList: state.difficultyList,
                  categoryList: state.categoryList,
                  typeList: state.typeList),
              child: const LoadSuccessPage(),
            );
          }
          if (state is RepositoryError) {
            return const ErrorPage();
          } else {
            return const ErrorPage();
          }
        },
      ),
    );
  }
}
