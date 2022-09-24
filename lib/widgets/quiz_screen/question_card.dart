import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/question.dart';
import '../../providers/questions.dart';

class QusetionCard extends StatefulWidget {
  final bool visible;
  final Function onEndFunction;
  const QusetionCard(
      {super.key, required this.visible, required this.onEndFunction});

  @override
  State<QusetionCard> createState() => _QusetionCardState();
}

class _QusetionCardState extends State<QusetionCard> {
  bool visible = true;
  @override
  Widget build(BuildContext context) {
    visible = widget.visible;
    final screenSize = MediaQuery.of(context);
    Question question =
        Provider.of<QuestionsProvider>(context).getCurrentQuestion();

    return Container(
      height: screenSize.size.height * 0.25,
      width: screenSize.size.width * 0.8,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey[400]!,
              offset: const Offset(0, 3),
              spreadRadius: 0,
              blurRadius: 10,
            )
          ]),
      child: Center(
          child: Padding(
        padding:
            const EdgeInsets.only(top: 40, left: 15, right: 15, bottom: 15),
        child: AnimatedOpacity(
          opacity: visible ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 800),
          onEnd: () => widget.onEndFunction(),
          child: AutoSizeText(
            question.question,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
          ),
        ),
      )),
    );
  }
}
