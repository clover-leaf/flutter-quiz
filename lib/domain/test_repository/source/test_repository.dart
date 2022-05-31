// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:chicken/common/common.dart';
import 'package:chicken/data/test_api/test_api.dart';

class TestRepository {
  const TestRepository({required TestApi testApi}) : _testApi = testApi;

  static final Map<String, String> categoryIconMap = {
    'Any': MyIcon.ANY.value,
    'General Knowledge': MyIcon.GENERAL.value,
    'Books': MyIcon.BOOK.value,
    'Film': MyIcon.FILM.value,
    'Music': MyIcon.MUSIC.value,
    'Video Games': MyIcon.GAME.value,
    'Board Games': MyIcon.BOARDGAME.value,
    'Nature': MyIcon.NATURE.value,
    'Computers': MyIcon.COMPUTER.value,
    'Mathematics': MyIcon.MATH.value,
    'Sports': MyIcon.SPORT.value,
    'Geography': MyIcon.GEOGRAPHY.value,
    'History': MyIcon.HISTORY.value,
    'Politics': MyIcon.POLITIC.value,
    'Celebrities': MyIcon.CELEB.value,
    'Animals': MyIcon.ANIMAL.value,
    'Vehicles': MyIcon.VEHICLE.value,
    'Gadgets': MyIcon.GADGET.value,
    'Anime & Manga': MyIcon.MANGA.value,
  };

  static final List<String> trimList = [
    'Entertainment:',
    'Japanese',
    'Science &',
    'Science:'
  ];

  final TestApi _testApi;

  Future<Test> getTest(Map<String, Map<String, dynamic>> parameters) async =>
      _testApi.getTest(parameters);

  Future<List<TestCategory>> getCategoryList() async {
    List<TestCategory> result = await _testApi.getCategoryList();
    result.insert(0, TestCategory(id: 0, name: 'Any'));
    List<TestCategory> filter = result
        .map((category) {
          String _name = category.name;
          for (String word in trimList) {
            if (category.name.contains(word)) {
              _name = _name.replaceFirstMapped(word, (match) => '').trim();
            }
          }
          return category.copyWith(name: _name);
        })
        .where((category) => categoryIconMap.containsKey(category.name))
        .map((category) =>
            category.copyWith(iconPath: categoryIconMap[category.name]))
        .toList();
    return filter;
  }

  List<TestDifficulty> getDifficultyList() => [
        TestDifficulty(id: '0', name: 'Any', iconPath: MyIcon.ANY.value),
        TestDifficulty(
            id: 'easy', name: 'Easy', iconPath: MyIcon.EASY.value),
        TestDifficulty(
            id: 'medium', name: 'Medium', iconPath: MyIcon.MEDIUM.value),
        TestDifficulty(
            id: 'hard', name: 'Hard', iconPath: MyIcon.HARD.value),
      ];

  List<TestType> getTypeList() => [
        TestType(id: '0', name: 'Any', iconPath: MyIcon.ANY.value),
        TestType(id: 'boolean', name: 'True / False', iconPath: MyIcon.TRUEFALSE.value),
        TestType(id: 'multiple', name: 'Multiple Choice', iconPath: MyIcon.MULTIPLE.value),
      ];
}
