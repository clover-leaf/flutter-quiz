import 'package:chicken/data/test_api/test_api.dart';

abstract class TestApi {
  const TestApi();

  Future<Test> getTest(Map<String, String> parameters);
}