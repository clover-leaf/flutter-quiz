import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:chicken/app/app_bloc_observer.dart';
import 'package:chicken/data/test_api/test_api.dart';
import 'package:chicken/domain/test_repository/test_repository.dart';
import 'package:flutter/widgets.dart';

import 'app/app.dart';

void bootstrap({required TestApi testApi}) {
  FlutterError.onError = (detail) {
    log(detail.exceptionAsString(), stackTrace: detail.stack);
  };

  final testRepository = TestRepository(testApi: testApi);

  runZonedGuarded(() async {
    await BlocOverrides.runZoned(
      () async => runApp(
        App(
          testRepository: testRepository,
        ),
      ),
      blocObserver: AppBlocObserver(),
    );
  }, (error, stackTrace) => log(error.toString(), stackTrace: stackTrace));
}
