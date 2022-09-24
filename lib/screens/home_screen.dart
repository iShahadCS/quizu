import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizu/providers/auth.dart';
import 'package:quizu/screens/quiz.dart';
import 'package:quizu/widgets/button.dart';
import 'package:quizu/widgets/profile_image.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<AuthProvider>(context).getCurrentUser;
    final screenSize = MediaQuery.of(context);
    // print(username);
    return Scaffold(
      backgroundColor: const Color(0xff7236ed),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              height:
                  screenSize.size.height * 0.20 - screenSize.viewPadding.top,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: screenSize.size.height * 0.09,
                        child: FittedBox(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "👋🏻 Hello, dear",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                currentUser.name,
                                style: const TextStyle(
                                    fontSize: 28,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ProfileImage(
                        size: screenSize.size.height * 0.09,
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  color: Color(0xfff9f9fe)),
              height:
                  screenSize.size.height * 0.80 - screenSize.viewPadding.top,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 30, right: 30, top: 40, bottom: 100),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                        "Ready to test your knoweldge and challenge others?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.w500)),
                    const SizedBox(
                      height: 20,
                    ),
                    Button(
                        onSubmitFunction: () =>
                            Navigator.of(context).pushNamed(Quiz.routeName),
                        text: "Quiz Me",
                        color: const Color(0xff140f5f)),
                    const SizedBox(
                      height: 20,
                    ),
                    Text("Answer as much questions correctly within 2 minutes",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[600])),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
