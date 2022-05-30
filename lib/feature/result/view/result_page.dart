import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chicken/data/test_api/test_api.dart' show Test;
import 'package:chicken/feature/result/result.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({Key? key, required this.parameters}) : super(key: key);

  final Map<String, dynamic> parameters;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ResultBloc()..add(ResultLoaded(test: Test.fromMap(parameters))),
      child: BlocBuilder<ResultBloc, ResultState>(
        builder: (context, state) {
          if (state is ResultInitial || state is ResultLoading) {
            return const LoadingPage();
          }
          if (state is ResultLoadSuccess) {
            return const SuccessPage();
          }
          return const ErrorPage();
        },
      ),
    );
  }
}
