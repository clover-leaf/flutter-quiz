import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chicken/feature/option/option.dart';
import 'package:chicken/data/test_api/test_api.dart' show TestCategory, TestDifficulty, TestType;

import 'package:chicken/feature/room/room.dart' show RoomPage;

class OptionPage extends StatelessWidget {
  const OptionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          OptionBloc(),
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
                  itemList: TestDifficulty.getAll(),
                  onChanged: (value) => context.read<OptionBloc>().add(
                      OptionDifficultyChanged(difficulty: value as String)),
                  value: state.difficulty),
              const SizedBox(
                height: 32,
              ),
              Dropdown(
                  label: 'Category',
                  itemList: TestCategory.getAll(),
                  onChanged: (value) => context
                      .read<OptionBloc>()
                      .add(OptionCategoryChanged(category: value as String)),
                  value: state.category),
              const SizedBox(
                height: 32,
              ),
              Dropdown(
                  label: 'Type',
                  itemList: TestType.getAll(),
                  onChanged: (value) => context
                      .read<OptionBloc>()
                      .add(OptionTypeChanged(type: value as String)),
                  value: state.type),
              const SizedBox(
                height: 32,
              ),
              GestureDetector(
                onTap: () {
                  final Map<String, String> parameters = {'amount': '30', 'duration': '600'};
                  if (state.category != 'Any') {
                    parameters['category'] = TestCategory.getValue(state.category);
                  }
                  if (state.difficulty != 'Any') {
                    parameters['difficulty'] = TestDifficulty.getValue(state.difficulty);
                  }
                  if (state.type != 'Any') {
                    parameters['type'] = TestType.getValue(state.type);
                  }
                  Navigator.of(context).push(MaterialPageRoute(
                    fullscreenDialog: true,
                      builder: (context) =>
                          RoomPage(parameters: parameters)));
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
