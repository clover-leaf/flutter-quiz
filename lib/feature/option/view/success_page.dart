// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:chicken/common/common.dart';
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
          padding: const EdgeInsets.fromLTRB(16, 32, 16, 64),
          child:  Column(
              children: [
                Text('Do quiz',
                    style: Theme.of(context)
                        .textTheme
                        .headline1!
                        .copyWith(fontSize: 24)),
                SizedBox(
                  height: Constant.PADDING.value * 2,
                ),
                const DifficultyOption(),
                SizedBox(
                  height: Constant.PADDING.value,
                ),
                const CategoryOption(),
                SizedBox(
                  height: Constant.PADDING.value,
                ),
                const TypeOption(),
                SizedBox(
                  height: Constant.PADDING.value,
                ),
                const AmountOption(),
                SizedBox(
                  height: Constant.PADDING.value,
                ),
                const DurationOption(),
                const Spacer(),
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
                    child: const StartButton()),
              ],
            ),
          ),
      ),
    );
  }
}
