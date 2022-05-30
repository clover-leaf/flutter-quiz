import 'package:chicken/data/test_api/test_api.dart';

abstract class TestApi {
  const TestApi();

  Future<Test> getTest(Map<String, Map<String, dynamic>> parameters);
  Future<List<TestCategory>> getCategoryList();
}