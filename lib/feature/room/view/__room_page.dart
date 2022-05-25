// import 'package:chicken/data/test_api/test_api.dart' show Answer;
// import 'package:chicken/domain/test_repository/source/test_repository.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:chicken/feature/room/room.dart';
// import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

// class _RoomPage extends StatelessWidget {
//   const _RoomPage({Key? key, required this.parameters}) : super(key: key);

//   // parameters = {
//   //   String type?  // value of type in url
//   //   String category?  // value of category in url
//   //   String difficulty?  // value of difficulty in url
//   //   String duration!
//   //   String amount!
//   // }
//   final Map<String, String> parameters;

//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(providers: [
//       BlocProvider(
//         create: (context) =>
//             LoadBloc(testRepository: context.read<TestRepository>())
//               ..add(Loaded(parameters: parameters)),
//       ),
//       BlocProvider(
//         create: (context) => RoomBloc(),
//       ),
//       // BlocProvider(
//       //     create: (context) => TestDurationBloc(
//       //         ticker: const Ticker(),
//       //         duration: int.parse(parameters['duration']!))),
//     ], child: _RoomView());
//   }
// }

// class _RoomView extends StatelessWidget {
//   _RoomView({Key? key}) : super(key: key);
//   final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
//   final ItemScrollController itemScrollController = ItemScrollController();

//   @override
//   Widget build(BuildContext context) {
//     // final testDurationState = context.watch<TestDurationBloc>().state;
//     final loadState = context.watch<LoadBloc>().state;
//     final navbarIdx = context.select<RoomBloc, int>((e) => e.state.navbarIdx);
//     final navbarIsTapped =
//         context.select<RoomBloc, bool>((e) => e.state.navbarTap);
//     final answerSheetState =
//         context.select<RoomBloc, List<Answer>>((e) => e.state.answerSheet);

//     return Scaffold(
//       key: scaffoldKey,
//       endDrawer: Sidebox(answerList: ),
//       onEndDrawerChanged: (isOpen) {
//         if (!isOpen & navbarIsTapped) {
//           itemScrollController.scrollTo(
//               index: navbarIdx, duration: const Duration(milliseconds: 600));
//           context.read<RoomBloc>().add(RoomNavbarReset());
//         }
//       },
//       body: SafeArea(
//           child: Padding(
//         padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 8),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   GestureDetector(
//                     behavior: HitTestBehavior.opaque,
//                     onTap: () => {print('tap')},
//                     child: SizedBox(
//                         height: 24,
//                         width: 24,
//                         child: Center(
//                           child: Image.asset('assets/images/chevron.png'),
//                         )),
//                   ),
//                   // if (testDurationState is TestDurationInitial)
//                   //   const Coolbox(
//                   //     bgColor: Colors.grey,
//                   //     width: 64,
//                   //   )
//                   // else if (testDurationState is TestDurationRunComplete)
//                   //   Coolbox(
//                   //     width: 64,
//                   //     bgColor: Colors.white,
//                   //     child: Text(
//                   //       testDurationState.duration.getTotalTime(),
//                   //       textAlign: TextAlign.center,
//                   //       style: TextStyle(
//                   //           fontSize: 12,
//                   //           color: Color(Palette.black.color),
//                   //           fontWeight: FontWeight.w700,
//                   //           height: 1.4),
//                   //     ),
//                   //   )
//                   // else
//                   //   GestureDetector(
//                   //       onTap: () {
//                   //         if (testDurationState is TestDurationRunInProgress) {
//                   //           context
//                   //               .read<TestDurationBloc>()
//                   //               .add(const TestDurationPaused());
//                   //         } else {
//                   //           context
//                   //               .read<TestDurationBloc>()
//                   //               .add(const TestDurationResumed());
//                   //         }
//                   //       },
//                   //       child: Magicbox(
//                   //         width: 64,
//                   //         activeBgColor: Color(Palette.sapphire.color),
//                   //         isActive:
//                   //             testDurationState is TestDurationRunInProgress,
//                   //         child: Text(
//                   //           testDurationState.duration.getRemainTime(),
//                   //           textAlign: TextAlign.center,
//                   //           style: TextStyle(
//                   //               fontSize: 12,
//                   //               color: testDurationState
//                   //                       is TestDurationRunInProgress
//                   //                   ? Colors.white
//                   //                   : Color(Palette.black.color),
//                   //               fontWeight: FontWeight.w700,
//                   //               height: 1.4),
//                   //         ),
//                   //       )),
//                   GestureDetector(
//                     behavior: HitTestBehavior.opaque,
//                     onTap: () => scaffoldKey.currentState?.openEndDrawer(),
//                     child: SizedBox(
//                         height: 24,
//                         width: 24,
//                         child: Center(
//                           child: Image.asset('assets/images/list.png'),
//                         )),
//                   ),
//                 ],
//               ),
//             ),
//             (() {
//               switch (loadState.runtimeType) {
//                 case Loading:
//                   return const CircularProgressIndicator();
//                 case LoadSuccess:
//                   return BlocListener<LoadBloc, LoadState>(
//                     listenWhen: (previous, current) =>
//                         (previous is Loading) & (current is LoadSuccess),
//                     listener: (context, state) {
//                       if (state is LoadSuccess) {
//                         context
//                             .read<RoomBloc>()
//                             .add(RoomCreated(quizzes: state.test.quizzes));
//                       }
//                     },
//                     child: BlocBuilder<RoomBloc, RoomState> (
//                       buildWhen: (previous, current) => (previous.answerSheet.isEmpty) & (current.answerSheet.isNotEmpty),
//                       builder: (context, state) {
//                         return state.answerSheet.isNotEmpty
//                         ? Expanded(
//                             child: ScrollablePositionedList.separated(
//                               itemScrollController: itemScrollController,
//                               itemCount: (loadState as LoadSuccess)
//                                   .test
//                                   .quizzes
//                                   .length,
//                               itemBuilder: (context, index) {
//                                 // build quiz
//                                 // final quiz = loadState.test.quizzes[index];
//                                 final quiz = context
//                                     .read<LoadSuccess>()
//                                     .test
//                                     .quizzes[index];
//                                 return Quizbox(quiz: quiz, quizIndex: index);
//                               },
//                               separatorBuilder: (context, index) =>
//                                   const Divider(),
//                             ),
//                           )
//                         : const CircularProgressIndicator();
//                       },
//                     )
//                   );
//                 case LoadFailure:
//                   return const Text('failure');
//                 default:
//                   return const Text('default');
//               }
//             })()
//           ],
//         ),
//       )),
//     );
//   }
// }
