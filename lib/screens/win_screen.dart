import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quizu/widgets/button.dart';
import 'package:quizu/widgets/circle_button.dart';
import 'package:share_plus/share_plus.dart';
import '../models/score.dart';

class WinScreen extends StatefulWidget {
  const WinScreen({super.key});
  static const routeName = '/win';

  @override
  State<WinScreen> createState() => _WinScreenState();
}

class _WinScreenState extends State<WinScreen> with TickerProviderStateMixin {
  AnimationController? _controller;
  Score? currentScore;
  bool isinit = true;

  @override
  void didChangeDependencies() {
    if (isinit) {
      currentScore = ModalRoute.of(context)!.settings.arguments as Score;
      _controller = AnimationController(vsync: this);
    }
    isinit = false;

    super.didChangeDependencies();
  }

  void shareButton() {
    Share.share(
        "I answered ${currentScore!.totalCorrectAnswers} correct answers in QuizU!");
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: const Color(0xff7236ed),
      body: SizedBox(
        height: screenSize.size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: screenSize.size.height * 0.5,
                  child: LottieBuilder.asset(
                    controller: _controller,
                    onLoaded: (comp) {
                      _controller!.duration = comp.duration;
                      _controller!.forward();
                    },
                    'assets/lottie/fireworks.json',
                  ),
                ),
                Image.asset(
                  "assets/icons/win.png",
                  height: screenSize.size.height * 0.25,
                ),
                Positioned(
                  top: screenSize.size.height * 0.42,
                  child: const Text(
                    'Congratulation!',
                    style: TextStyle(
                        color: Color(0xffffbb33),
                        fontSize: 35,
                        fontWeight: FontWeight.w500,
                        shadows: [
                          Shadow(
                              blurRadius: 15,
                              color: Colors.white38,
                              offset: Offset(0, 3))
                        ]),
                  ),
                ),
                Positioned(
                    top: 40,
                    right: 5,
                    child: CircleButton(
                      icon: Icons.close_rounded,
                      onTap: () {
                        Navigator.of(context).pushReplacementNamed("/");
                      },
                    ))
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            const Text('You have completed',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                )),
            const SizedBox(
              height: 15,
            ),
            Text(currentScore!.totalCorrectAnswers.toString(),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 50,
                    fontWeight: FontWeight.w600)),
            const SizedBox(
              height: 15,
            ),
            const Text('correct answers!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                )),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Button(
                  onSubmitFunction: () => shareButton(),
                  text: "Share",
                  color: const Color(0xff140f5f)),
            )
          ],
        ),
      ),
    );
  }
}
