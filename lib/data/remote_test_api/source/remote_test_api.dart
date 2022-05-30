// ignore_for_file: non_constant_identifier_names, no_leading_underscores_for_local_identifiers

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:collection/collection.dart';

import 'package:chicken/data/test_api/test_api.dart';

class RemoteTestApi extends TestApi {
  const RemoteTestApi({required httpClient}) : _httpClient = httpClient;

  final http.Client _httpClient;
  static const String _baseURL = 'opentdb.com';

  // parameters = {
  //    'category': {
  //                  'id': 1,
  //                  'name': 'math',
  //                },
  //    'difficulty': {
  //                  'id': 'medium',
  //                  'name': 'Medium',
  //                },
  //    'type': {
  //                  'id': '0',
  //                  'name': 'any',
  //                },
  //    'amount': {
  //                'id': '30'
  //              },
  //    'duration': {
  //                  'remain': 600,
  //                  'label': 600,
  //                },
  // }
  @override
  Future<Test> getTest(Map<String, Map<String, dynamic>> parameters) async {
    final Map<String, String> _parameters = {};
    print(parameters);
    try {
      if (parameters['category']!['id']! != 0) {
        _parameters['category'] = parameters['category']!['id']!.toString();
      }
      if (parameters['difficulty']!['id']! != '0') {
        _parameters['difficulty'] = parameters['difficulty']!['id']!;
      }
      if (parameters['type']!['id']! != '0') {
        _parameters['type'] = parameters['type']!['id']!;
      }
      _parameters['amount'] = parameters['amount']!['id']!;
    } catch (e) {
      print(e);
    }

    // add encode mode
    _parameters['encode'] = 'url3986';
    const String path = '/api.php';
    final response =
        await _httpClient.get(Uri.https(_baseURL, path, _parameters));

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      final List<Quiz> quizzes =
          (body['results'] as List<dynamic>).mapIndexed((index, value) {
        final List<String> raw_answer =
            List<String>.from(value['incorrect_answers']);
        raw_answer.add(value['correct_answer'] as String);
        final List<String> decode_answer =
            raw_answer.map((ans) => Uri.decodeComponent(ans)).toList();
        final List<Answer> answers = decode_answer
            .mapIndexed((_index, value) => Answer(
                id: _index,
                quizId: index,
                quizLabel: (index + 1).toString(),
                label: 'A',
                answer: value,
                isCorrect: _index == raw_answer.length - 1))
            .toList();
        answers.shuffle();
        List<Answer> shuffle_answer = answers
            .mapIndexed((_index, ans) => ans.copyWith(
                id: _index, label: ['A', 'B', 'C', 'D', 'E', 'F'][_index]))
            .toList();
        final String decode_question =
            Uri.decodeComponent(value['question'] as String);
        return Quiz(
            id: index,
            label: (index + 1).toString(),
            question: decode_question,
            answers: shuffle_answer);
      }).toList();
      // create prototype answers list
      final List<Answer> answers = [];
      for (var quiz in quizzes) {
        answers.add(Answer(
            id: -1,
            quizId: quiz.id,
            quizLabel: quiz.label,
            label: '',
            answer: '',
            isCorrect: false));
      }
      final test = Test(
          difficulty: TestDifficulty.fromMap(parameters['difficulty']!),
          type: TestType.fromMap(parameters['type']!),
          category: TestCategory.fromMap(parameters['category']!),
          duration: TestDuration.fromMap(parameters['duration']!),
          answers: answers,
          quizzes: quizzes);
      return test;
    } else {
      throw Exception('cant get test');
    }
  }

  @override
  Future<List<TestCategory>> getCategoryList() async {
    const String path = '/api_category.php';
    final response = await _httpClient.get(Uri.https(_baseURL, path));

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      final List<TestCategory> categoryList =
          (body['trivia_categories'] as List<dynamic>).map((e) {
        return TestCategory.fromMap(e);
      }).toList();
      return categoryList;
    } else {
      throw Exception('cant get test');
    }
  }
}
