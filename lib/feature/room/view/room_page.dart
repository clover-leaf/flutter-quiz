import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chicken/domain/test_repository/test_repository.dart'
    show TestRepository;
import 'package:chicken/feature/room/room.dart';

class RoomPage extends StatelessWidget {
  const RoomPage({Key? key, required this.parameters}) : super(key: key);

  final Map<String, Map<String, dynamic>> parameters;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          RepositoryBloc(testRepository: context.read<TestRepository>())
            ..add(GetTest(parameters)),
      child: BlocConsumer<RepositoryBloc, RepositoryState>(
        listener: (context, state) {
          if (state is RepositoryError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.msg ?? 'error happen when fetching api'),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is RepositoryLoading || state is RepositoryInitial) {
            return const LoadingPage();
          }
          if (state is RepositoryLoaded) {
            final double deviceHeight = MediaQuery.of(context).size.height;
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => UtilBloc(
                      deviceHeight: deviceHeight,
                      initOffset: deviceHeight * 3 / 5,
                      ),
                ),
                BlocProvider(
                  create: (context) => AnswerBloc(
                      answersheet: state.test.answers,
                      ),
                ),
                BlocProvider(
                    create: (context) =>
                        TimerBloc()..add(TimerStart(state.test.duration))),
              ],
              child: TestPage(),
            );
          }
          if (state is RepositoryError) {
            return const ErrorPage();
          }
          return const NotFoundPage();
        },
      ),
    );
  }
}
