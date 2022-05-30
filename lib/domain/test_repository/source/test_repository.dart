import 'package:chicken/data/test_api/test_api.dart';

class TestRepository {
  const TestRepository({required TestApi testApi}) : _testApi = testApi;

  final TestApi _testApi;

  Future<Test> getTest(Map<String, Map<String, dynamic>> parameters) async =>
      _testApi.getTest(parameters);

  Future<List<TestCategory>> getCategoryList() async {
    List<TestCategory> result = await _testApi.getCategoryList();
    result.insert(0, TestCategory(id: 0, name: 'Any'));
    List<TestCategory> filter = result.map((category) {
      if (category.name.contains('Entertainment:')) {
        return category.copyWith(
            name: category.name
                .replaceFirstMapped('Entertainment:', (match) => '')
                .trim());
      }
      if (category.name.contains('Science:')) {
        return category.copyWith(
            name: category.name
                .replaceFirstMapped('Science:', (match) => '')
                .trim());
      }
      return category;
    }).toList();
    return filter;
  }

  List<TestDifficulty> getDifficultyList() => [
        TestDifficulty(
          id: '0',
          name: 'Any',
        ),
        TestDifficulty(id: 'easy', name: 'Easy'),
        TestDifficulty(id: 'medium', name: 'Medium'),
        TestDifficulty(id: 'hard', name: 'Hard'),
      ];

  List<TestType> getTypeList() => [
        TestType(id: '0', name: 'Any'),
        TestType(id: 'boolean', name: 'True / False'),
        TestType(id: 'multiple', name: 'Multiple'),
      ];
}
