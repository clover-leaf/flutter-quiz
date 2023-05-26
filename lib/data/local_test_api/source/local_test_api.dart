import 'dart:convert';

import 'package:chicken/data/test_api/test_api.dart';
import 'package:collection/collection.dart';

class LocalTestApi extends TestApi {
  const LocalTestApi();

  @override
  Future<Test> getTest(Map<String, Map<String, dynamic>> parameters) async {
    print('begin');
    String raw = """
      [
        {
          "question": "若い大統領には経験不足という _______ がある。",
          "incorrect_answers": ["弱点","飢饉","落第"],
          "correct_answer":"過失"
        },
        {
          "question": "ここの研究 ____ の多くは古代言語で記された文章を含んでいる。",
          "incorrect_answers": ["給料","資料","送料"],
          "correct_answer":"原料"
        },
        {
          "question": "_______ されている象牙の在庫が底を突いた後、大量生産ができなければ、密猟業者が参入してくる。",
          "incorrect_answers": ["持続","整備","維持"],
          "correct_answer":"貯蔵"
        },
        {
          "question": "象牙の売却許可が発表された _______ 、密猟は６６％、密売は７１％増加したとされる。",
          "incorrect_answers": ["直接","直通","直線"],
          "correct_answer":"直後"
        },
        {
          "question": "彼は高校の転入 _______ もすでにすませていて、車を買うのにも協力してくれた。",
          "incorrect_answers": ["配置","手続","処理"],
          "correct_answer":"作業"
        },
        {
          "question": "新たな _______ になると、気になりはじめるのが健康診断です。",
          "incorrect_answers": ["年鑑","年月","年齢"],
          "correct_answer":"年度"
        },
        {
          "question": "今日は先輩がサッカーの試合に出るので、友達と一緒に _______ に行った。",
          "incorrect_answers": ["参加","競争","応援"],
          "correct_answer":"指導"
        },
        {
          "question": "受け取った後、必ず箱の _______ を確認してください。",
          "incorrect_answers": ["最中","中身","以内"],
          "correct_answer":"仲間"
        },
        {
          "question": "彼は辛いことがあっても、_______ な顔をしている。",
          "incorrect_answers": ["得意","正直","不安"],
          "correct_answer":"平気"
        },
        {
          "question": "彼の説明はいつも長くて _______ ので、いらいらする。",
          "incorrect_answers": ["えらい","くどい","かゆい"],
          "correct_answer":"ゆるい"
        }
      ]
    """;
    final body = json.decode(raw);
    final List<Quiz> quizzes =
        (body as List<dynamic>).mapIndexed((quizIndex, value) {
      final List<String> rawAnswer =
          List<String>.from(value['incorrect_answers']);
      rawAnswer.add(value['correct_answer'] as String);
      final List<Answer> answers = rawAnswer
          .mapIndexed((index, value) => Answer(
              id: index,
              quizId: quizIndex,
              quizLabel: (quizIndex + 1).toString(),
              label: 'A',
              answer: value,
              isCorrect: index == rawAnswer.length - 1))
          .toList();
      answers.shuffle();
      List<Answer> shuffleAnswer = answers
          .mapIndexed((index, ans) => ans.copyWith(
              id: index, label: ['A', 'B', 'C', 'D', 'E', 'F'][index]))
          .toList();
      return Quiz(
          id: quizIndex,
          label: (quizIndex + 1).toString(),
          question: value['question'] as String,
          answers: shuffleAnswer);
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
    return Test(
        difficulty: TestDifficulty.fromMap(parameters['difficulty']!),
        type: TestType.fromMap(parameters['type']!),
        category: TestCategory.fromMap(parameters['category']!),
        duration: TestDuration.fromMap(parameters['duration']!),
        answers: answers,
        quizzes: quizzes);
  }

  @override
  Future<List<TestCategory>> getCategoryList() async {
    return [];
  }
}
