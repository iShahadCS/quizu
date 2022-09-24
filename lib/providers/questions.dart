import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/question.dart';

class QuestionsProvider with ChangeNotifier {
  int currentQuestion = 0;

  List<Question> questions = [];
  Future<void> fetchQuestions() async {
    final url = Uri.parse('https://quizu.okoul.com/Questions');
    final localStorage = await SharedPreferences.getInstance();
    if (localStorage.containsKey("token")) {
      final token = localStorage.getString("token");
      final respone = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      final responseData = json.decode(respone.body);
      for (var i in responseData) {
        questions.add(Question(
            question: i['Question'],
            answers: {"a": i['a'], "b": i['b'], "c": i['c'], "d": i['d']},
            correctAnswer: i['correct']));
      }
    }
  }

  bool checkChosenAnswer(String answer) {
    var getAnswerKey = questions[currentQuestion]
        .answers
        .keys
        .firstWhere((k) => questions[currentQuestion].answers[k] == answer);
    if (getAnswerKey == questions[currentQuestion].correctAnswer) {
      Future.delayed(const Duration(milliseconds: 800), () {
        currentQuestion++;
        notifyListeners();
      });
      return true;
    } else {
      return false;
    }
  }

  Question getCurrentQuestion() {
    return questions[currentQuestion];
  }

  void skipQuestion() {
    currentQuestion++;
    notifyListeners();
  }

  void resetIndex() {
    currentQuestion = 0;
  }
}
