import 'package:chicken/bootstrap.dart';
import 'package:chicken/data/remote_test_api/remote_test_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  RemoteTestApi testApi = RemoteTestApi(httpClient: http.Client());
  // LocalTestApi testApi = const LocalTestApi();

  bootstrap(testApi: testApi);
}
