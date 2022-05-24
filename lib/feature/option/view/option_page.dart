import 'package:chicken/domain/test_repository/test_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chicken/feature/option/option.dart';
import 'package:chicken/common/common.dart';

class OptionPage extends StatelessWidget {
  const OptionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          OptionBloc(testRepository: context.read<TestRepository>()),
      child: const OptionView(),
    );
  }
}

class OptionView extends StatelessWidget {
  const OptionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<OptionBloc>().state;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(32, 64, 32, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Let's take quiz!",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              const SizedBox(
                height: 64,
              ),
              Dropdown(
                  label: 'Difficulty',
                  itemList: TestDifficulty.values,
                  onChanged: (value) => context.read<OptionBloc>().add(
                      OptionDifficultyChanged(
                          difficulty: value as TestDifficulty)),
                  value: state.difficulty),
              const SizedBox(
                height: 32,
              ),
              Dropdown(
                  label: 'Category',
                  itemList: TestCategory.values,
                  onChanged: (value) => context.read<OptionBloc>().add(
                      OptionCategoryChanged(category: value as TestCategory)),
                  value: state.category),
              const SizedBox(
                height: 32,
              ),
              Dropdown(
                  label: 'Type',
                  itemList: TestType.values,
                  onChanged: (value) => context
                      .read<OptionBloc>()
                      .add(OptionTypeChanged(type: value as TestType)),
                  value: state.type),
              const SizedBox(
                height: 32,
              ),
              GestureDetector(
                onTap: () {
                  final Map<String, String> parameters = {};
                  if (state.category != TestCategory.any) {
                    parameters['category'] = state.category.value;
                  }
                  if (state.difficulty != TestDifficulty.any) {
                    parameters['difficulty'] = state.difficulty.value;
                  }
                  if (state.type != TestType.any) {
                    parameters['type'] = state.type.value;
                  }
                  Navigator.of(context).pushNamed('/room', arguments: {
                    'parameters': parameters,
                    'duration': 3599
                  });
                },
                child: const Coolbox().copyWith(
                  width: 120,
                  height: 40,
                  text: 'Start',
                  bgColor: Colors.green,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
