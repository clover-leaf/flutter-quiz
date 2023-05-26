import 'package:chicken/bootstrap.dart';
import 'package:chicken/data/remote_test_api/remote_test_api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final testApi = RemoteTestApi(httpClient: http.Client());
  // LocalTestApi testApi = const LocalTestApi();

  bootstrap(testApi: testApi);
}
