
import 'package:chicken/data/test_api/test_api.dart';

class TestRepository {
  const TestRepository(
    {required TestApi testApi}
  ) : _testApi = testApi;

  final TestApi _testApi;

  Future<Test> getTest(Map<String, String> parameters) async => _testApi.getTest(parameters);
}