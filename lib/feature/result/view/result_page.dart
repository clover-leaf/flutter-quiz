// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:chicken/data/test_api/test_api.dart' show Test;
// import 'package:chicken/feature/result/result.dart';
// import 'package:chicken/common/common.dart';

// class ResultPage extends StatelessWidget {
//   const ResultPage({Key? key, required this.parameters}) : super(key: key);

//   final Map<String, dynamic> parameters;

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) =>
//           ResultBloc()..add(ResultLoaded(test: Test.fromMap(parameters))),
//       child: const ResultView(),
//     );
//   }
// }

// class ResultView extends StatelessWidget {
//   const ResultView({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final resultState = context.watch<ResultBloc>().state;

//     return Scaffold(
//       body: WillPopScope(
//         onWillPop: () async => false,
//         child: Padding(
//             padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 if (resultState is ResultLoadSuccess) ...[
//                   SizedBox(
//                     height: 200,
//                     width: 200,
//                     child: Container(
//                       decoration: BoxDecoration(
//                           borderRadius:
//                               const BorderRadius.all(Radius.circular(100)),
//                           border: Border.all(color: Color(Palette.black.color), width: 2.4)),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                            Text(
//                             'Score',
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                                 fontSize: 14,
//                                 color: Color(Palette.black.color),
//                                 fontWeight: FontWeight.bold),
//                           ),
//                           const SizedBox(
//                             height: 8,
//                           ),
//                           Text(
//                             '${resultState.getCorrectAnswer}/${resultState.test.quizzes.length}',
//                             textAlign: TextAlign.center,
//                             style:  TextStyle(
//                                 fontSize: 28,
//                                 color: Color(Palette.black.color),
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.fromLTRB(64, 32, 64, 32),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Expanded(
//                             child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             TagLabel(
//                                 tag: 'Difficulty',
//                                 content: resultState.test.difficulty.label),
//                             const SizedBox(
//                               height: 16,
//                             ),
//                             TagLabel(
//                                 tag: 'Time',
//                                 content: resultState.test.duration.getUsedTime),
//                           ],
//                         )),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             TagLabel(
//                                 tag: 'Category',
//                                 content: resultState.test.category.label),
//                             const SizedBox(
//                               height: 16,
//                             ),
//                             TagLabel(
//                                 tag: 'Type',
//                                 content: resultState.test.type.label),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(top: 8),
//                     child: GestureDetector(
//                       onTap: () => Navigator.of(context).pushNamed('/review'),
//                       child: Coolbox(
//                         width: 104,
//                         height: 40,
//                         bgColor: Color(Palette.sapphire.color),
//                         child: const Text('Review quiz',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 13,
//                               fontWeight: FontWeight.bold,
//                             )),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(top: 8.0),
//                     child: GestureDetector(
//                       onTap: () {
//                         Navigator.of(context).pushNamed('/');
//                       },
//                       child: Coolbox(
//                         width: 120,
//                         height: 40,
//                         bgColor: Color(Palette.sapphire.color),
//                         child: const Text('Take new quiz',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 13,
//                               fontWeight: FontWeight.bold,
//                             )),
//                       ),
//                     ),
//                   ),
//                 ]
//               ],
//             )),
//       ),
//     );
//   }
// }
