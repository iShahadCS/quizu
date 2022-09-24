import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final Function onSubmitFunction;
  final String text;
  final Color color;
  final double? height;
  const Button(
      {super.key,
      this.height,
      required this.onSubmitFunction,
      required this.text,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height ?? 60,
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(color),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)))),
        onPressed: () => onSubmitFunction(),
        child: Text(
          text,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
