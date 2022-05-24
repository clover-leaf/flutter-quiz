import 'package:chicken/feature/room/room.dart';
import 'package:flutter/material.dart';
import 'package:chicken/data/test_api/test_api.dart' show Answer;
import 'package:chicken/common/common.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class Navbar extends StatelessWidget {
  const Navbar({
    super.key,
    required this.answerSheet,
    required this.onTap,
  });

  final List<Answer> answerSheet;
  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return Drawer(
        elevation: 0,
        width: 96,
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 120, horizontal: 8),
          child: Column(
            children: [
              SizedBox(
                height: 40,
                child: Center(
                  child: Text(
                    'Answer',
                    style: TextStyle(
                      color: Color(Palette.black.color),
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 480,
                child: ScrollablePositionedList.separated(
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 8,
                        ),
                    itemCount: answerSheet.length,
                    itemBuilder: (context, idx) {
                      final ans = answerSheet[idx];
                      final bool isAnswered = ans.id != -1;
                      return GestureDetector(
                        onTap: () {
                          onTap.call(idx);
                        },
                        child: Coolbox(
                          width: 52,
                          bgColor: isAnswered
                              ? Color(Palette.black.color)
                              : Colors.white,
                          child: Text('${ans.quizLabel}.${ans.label}',
                              style: TextStyle(
                                color: isAnswered
                                    ? Colors.white
                                    : Color(Palette.black.color),
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      );
                    }),
              ),
              Coolbox(
                width: 64,
                bgColor: Color(Palette.sapphire.color),
                child: const Text('Submit',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    )),
              )
            ],
          ),
        ));
  }
}
