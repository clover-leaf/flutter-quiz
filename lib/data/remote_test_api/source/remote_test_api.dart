// ignore_for_file: non_constant_identifier_names, no_leading_underscores_for_local_identifiers

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:collection/collection.dart';

import 'package:chicken/data/test_api/test_api.dart';

class RemoteTestApi extends TestApi {
  const RemoteTestApi({required httpClient}) : _httpClient = httpClient;

  final http.Client _httpClient;
  final String _baseURL = 'opentdb.com';
  final String _basePath = '/api.php';

  @override
  Future<Test> getTest(Map<String, String> parameters) async {
    if (!(parameters.containsKey('amount') &
        parameters.containsKey('duration'))) {
      throw Exception('not contain enough parameter to get api');
    }
    final int duration = int.parse(parameters['duration']!);
    // remove duration para because api dont need it
    parameters.remove('duration');
    parameters['encode'] = 'url3986';
    final response =
        await _httpClient.get(Uri.https(_baseURL, _basePath, parameters));

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
      final test = Test(
          difficulty: TestDifficulty(label: parameters['difficulty'] ?? 'Any'),
          type: TestType(label: parameters['type'] ?? 'Any'),
          category: TestCategory(label: parameters['category'] ?? 'Any'),
          duration: TestDuration(total: duration, remain: duration),
          answers: [],
          quizzes: quizzes);
      return test;
    } else {
      throw Exception('cant get test');
    }
  }
}
