import 'package:flutter/material.dart';

class CountDown extends StatelessWidget {
  final int start;
  final int min;
  final int sec;
  const CountDown(
      {super.key, required this.start, required this.min, required this.sec});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context);

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            height: screenSize.size.height * 0.09,
            width: screenSize.size.height * 0.09,
            child: CircularProgressIndicator(
              semanticsLabel: '120',
              value: ((start * 100) / 120) / 100,
              valueColor: AlwaysStoppedAnimation(
                  start > 20 ? const Color(0xff140f5f) : Colors.red),
              strokeWidth: 7,
            ),
          ),
          FittedBox(
              child: Text(
            '$min:$sec',
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: start > 20 ? const Color(0xff140f5f) : Colors.red),
          )),
        ],
      ),
    );
  }
}
