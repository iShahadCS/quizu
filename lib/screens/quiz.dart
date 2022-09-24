import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quizu/models/score.dart';
import 'package:quizu/providers/questions.dart';
import 'package:quizu/providers/scores.dart';
import 'package:quizu/screens/win_screen.dart';
import '../widgets/button.dart';
import '../widgets/quiz_screen/answers_list.dart';
import '../widgets/quiz_screen/countdown.dart';
import '../widgets/quiz_screen/question_card.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});
  static const routeName = '/quiz';

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  Timer? _timer;
  int min = 1;
  int sec = 59;
  int start = 120;
  int totalCorrectAnswers = 0;
  String timeStarted = '';
  Score? currentScore;

  void startTimer() async {
    timeStarted = DateFormat.yMd().add_jm().format(DateTime.now());
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (timer) {
      if (sec == 0 && min == 0) {
        setState(() {
          timer.cancel();
        });
        currentScore = Score(
            timeStarted: timeStarted, totalCorrectAnswers: totalCorrectAnswers);
        Provider.of<ScoresProvider>(context, listen: false)
            .postScore(currentScore!);
        Provider.of<ScoresProvider>(context, listen: false)
            .addUserScore(currentScore!);
        Navigator.of(context)
            .pushReplacementNamed(WinScreen.routeName, arguments: currentScore);
      } else if (sec == 0) {
        setState(() {
          min--;
          sec = 60;
          start--;
        });
      } else {
        setState(() {
          sec--;
          start--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  @override
  void initState() {
    Provider.of<QuestionsProvider>(context, listen: false).resetIndex();

    startTimer();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  bool canPressSkip = true;
  void skipButton() {
    if (canPressSkip) {
      Provider.of<QuestionsProvider>(context, listen: false).skipQuestion();
    }
    setState(() {
      canPressSkip = false;
    });
  }

  bool visible = true;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context);
    return Scaffold(
        backgroundColor: const Color(0xff7236ed),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                SizedBox(
                  height: screenSize.size.height,
                ),
//answers card ---------------------------------------------------------------------------------------
                Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      color: Colors.white),
                  height: screenSize.size.height * 0.80 -
                      screenSize.viewPadding.top,
                  width: double.infinity,
                  child: Padding(
                      padding: EdgeInsets.only(
                          top: screenSize.size.height * 0.35 / 2,
                          bottom: screenSize.size.height * 0.04),
                      child: Column(
                        children: [
                          Expanded(child: AnswersList(
                            correctAnswerPressed: (val) {
                              if (val) {
                                totalCorrectAnswers++;
                                setState(() {
                                  visible = false;
                                });
                              } else {
                                _timer!.cancel();
                              }
                            },
                          )),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: (screenSize.size.width -
                                          (screenSize.size.width * 0.8)) /
                                      2 +
                                  100,
                            ),
                            //skip button ------------------------------------------------------
                            child: Button(
                                onSubmitFunction: () => skipButton(),
                                height: screenSize.size.height * 0.085,
                                text: "Skip",
                                color: canPressSkip
                                    ? const Color(0xffff9431)
                                    : Colors.grey[400]!),
                          )
                        ],
                      )),
                ),
//question card -----------------------------------------------------------------------------
                Positioned(
                    bottom: screenSize.size.height * 0.68 -
                        screenSize.viewPadding.top,
                    child: QusetionCard(
                        visible: visible,
                        onEndFunction: () {
                          setState(() {
                            visible = true;
                          });
                        })),
//counter circle --------------------------------------------------------------------------
                Positioned(
                  bottom: screenSize.size.height * 0.88 -
                      screenSize.viewPadding.top,
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(70),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[400]!,
                              offset: const Offset(0, 2),
                              spreadRadius: 0,
                              blurRadius: 10,
                            )
                          ]),
                      height: screenSize.size.height * 0.1,
                      width: screenSize.size.height * 0.1,
                      child: CountDown(
                        min: min,
                        sec: sec,
                        start: start,
                      )),
                )
              ],
            )
          ],
        ));
  }
}
