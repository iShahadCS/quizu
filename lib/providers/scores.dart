import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:quizu/models/leaderboard_score.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../models/score.dart';

class ScoresProvider with ChangeNotifier {
  List<Score> userScores = [];
  List<String> localStorageUserScores = [];
  List<LeaderboardScore> leaderBored = [];

  Future<void> postScore(Score score) async {
    final url = Uri.parse("https://quizu.okoul.com/Score");
    final localStorage = await SharedPreferences.getInstance();
    if (localStorage.containsKey("token")) {
      final token = localStorage.getString("token");
      final response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token',
          },
          body: json.encode({"score": score.totalCorrectAnswers}));

      final responseBody = json.decode(response.body);
      print(responseBody);
    }
  }

  Future<void> leaderBoard() async {
    final url = Uri.parse("https://quizu.okoul.com/TopScores");
    final localStorage = await SharedPreferences.getInstance();
    if (localStorage.containsKey("token")) {
      final token = localStorage.getString("token");
      final response = await http.get(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      });

      final responseBody = json.decode(response.body);
      for (var i in responseBody) {
        leaderBored.add(LeaderboardScore(name: i["name"], score: i["score"]));
      }
    }
  }

  void addUserScore(Score score) async {
    localStorageUserScores.clear();
    final localStorage = await SharedPreferences.getInstance();

    if (localStorage.containsKey("userScores")) {
      var retrieveList = localStorage.getStringList("userScores") == null
          ? []
          : localStorage.getStringList("userScores")!;

      for (var i in retrieveList) {
        localStorageUserScores.add(i);
      }
      localStorageUserScores.add(json.encode({
        "timeStarted": score.timeStarted,
        "totalCorrectAnswers": score.totalCorrectAnswers
      }));
    } else {
      localStorageUserScores.add(json.encode({
        "timeStarted": score.timeStarted,
        "totalCorrectAnswers": score.totalCorrectAnswers
      }));
    }
    localStorage.setStringList("userScores", localStorageUserScores);
    convrtLocalStorageStringToObject();
  }

  void convrtLocalStorageStringToObject() async {
    final localStorage = await SharedPreferences.getInstance();

    var retrieveList = localStorage.getStringList("userScores") == null
        ? []
        : localStorage.getStringList("userScores")!;

    userScores.clear();
    retrieveList.forEach((i) {
      userScores.add(Score(
          timeStarted: json.decode(i)["timeStarted"],
          totalCorrectAnswers: json.decode(i)["totalCorrectAnswers"]));
    });
  }

  List<Score> get getUserScores {
    return [...userScores];
  }

  List<LeaderboardScore> get getLeaderBoardScores {
    return [...leaderBored];
  }

  void logOut() {
    userScores = [];
    localStorageUserScores = [];
    leaderBored = [];
    notifyListeners();
  }
}
