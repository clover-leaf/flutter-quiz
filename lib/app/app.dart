import 'package:chicken/domain/test_repository/test_repository.dart';
import 'package:chicken/feature/option/option.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({Key? key, required this.testRepository}) : super(key: key);

  final TestRepository testRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: testRepository,
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme,
        ),
        dividerTheme: DividerThemeData(
          space: 16,
          thickness: 1.6,
          color: Colors.black.withOpacity(0.7),
        ),
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      // routes: {
      //   '/': (_) => const OptionPage(),
      //   '/room': (_) => const RoomPage(),
      //   '/result': (_) => const ResultPage(),
      // },
      home: const OptionPage()
    );
  }
}
