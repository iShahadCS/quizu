import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizu/models/question.dart';
import 'package:quizu/screens/quiz.dart';
import '../../providers/questions.dart';
import '../message_dialog.dart';

class AnswersList extends StatefulWidget {
  final Function correctAnswerPressed;
  const AnswersList({super.key, required this.correctAnswerPressed});

  @override
  State<AnswersList> createState() => _AnswersListState();
}

class _AnswersListState extends State<AnswersList> {
  bool showCorrect = false;
  bool visible = true;
  bool answerStatus = false;
  String chosenAnswer = '';

  @override
  Widget build(BuildContext context) {
    Question question =
        Provider.of<QuestionsProvider>(context).getCurrentQuestion();
    List answers = question.answers.values.toList();
    final screenSize = MediaQuery.of(context);

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(
        horizontal: (screenSize.size.width - (screenSize.size.width * 0.8)) / 2,
      ),
      itemCount: 4,
      itemBuilder: (context, i) => Column(
        children: [
          GestureDetector(
            onTap: () {
              chosenAnswer = answers[i];
              answerStatus =
                  Provider.of<QuestionsProvider>(context, listen: false)
                      .checkChosenAnswer(chosenAnswer);

              widget.correctAnswerPressed(answerStatus);
              if (answerStatus) {
                setState(() {
                  visible = false;
                  showCorrect = true;
                });
              } else {
                showDialog(
                    context: context,
                    builder: (context) => MessageDialog(
                          firstButtonFunctoin: () {
                            Navigator.of(context)
                                .pushReplacementNamed(Quiz.routeName);
                          },
                          image: 'assets/icons/wrong.png',
                          title: "Wrong answer",
                          buttonText: 'Try Again',
                          extraButton: true,
                          buttonText2: 'Close',
                          secondButtonFunction: () =>
                              Navigator.of(context).pushReplacementNamed('/'),
                        ));
              }
            },
            child: AnimatedOpacity(
              opacity: visible ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 800),
              onEnd: () {
                setState(() {
                  visible = true;
                  showCorrect = false;
                });
              },
              child: Container(
                width: double.infinity,
                height: screenSize.size.height * 0.085,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: i == answers.indexOf(chosenAnswer) && showCorrect
                            ? Colors.greenAccent
                            : Colors.grey[200]!,
                        width: 5),
                    borderRadius: BorderRadius.circular(15)),
                child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      answers[i],
                      style: const TextStyle(fontSize: 20),
                    )),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          )
        ],
      ),
    );
  }
}
