// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';

import 'package:chicken/feature/option/option.dart';
import 'package:chicken/feature/room/room.dart' show RoomPage;
import 'package:flutter_bloc/flutter_bloc.dart';

class LoadSuccessPage extends StatelessWidget {
  const LoadSuccessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(32, 32, 32, 16),
          child: Column(
            children: [
              Text('Do quiz',
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(fontSize: 24)),
              const SizedBox(
                height: 32,
              ),
              const DifficultyOption(),
              const SizedBox(
                height: 32,
              ),
              const CategoryOption(),
              const SizedBox(
                height: 32,
              ),
              const TypeOption(),
              const SizedBox(
                height: 32,
              ),
              const AmountOption(),
              const SizedBox(
                height: 32,
              ),
              const DurationOption(),
              const SizedBox(
                height: 32,
              ),
              GestureDetector(
                  onTap: () {
                    UtilState _state = context.read<UtilBloc>().state;
                    Map<String, Map<String, dynamic>> _parameters = {
                      'category': _state.categoryList[_state.categoryIndex].toMap(),
                      'difficulty': _state.difficultyList[_state.difficultyIndex].toMap(),
                      'type': _state.typeList[_state.typeIndex].toMap(),
                      'amount': {'id': _state.amount.toString()},
                      'duration': _state.duration.toMap()
                    };
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => RoomPage(parameters: _parameters)));
                  },
                  child: const StartButton())
            ],
          ),
        ),
      ),
    );
  }
}
