import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizu/providers/questions.dart';
import 'package:quizu/screens/home_screen.dart';
import 'package:quizu/screens/leaderboard_screen.dart';
import 'package:quizu/screens/profile_screen.dart';

import '../providers/scores.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});
  static const routeName = '/navbar';

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedScreen = 0;

  final PageController _pageController = PageController();

  bool isinit = true;

  @override
  void didChangeDependencies() {
    if (isinit) {
      Provider.of<QuestionsProvider>(context, listen: false).fetchQuestions();
      Provider.of<ScoresProvider>(context, listen: false).leaderBoard();
      Provider.of<ScoresProvider>(context, listen: false)
          .convrtLocalStorageStringToObject();
    }
    isinit = false;
    super.didChangeDependencies();
  }

  Widget bottomNavBar(BuildContext context, int currentIndex) {
    return Container(
      height: 95,
      alignment: Alignment.topCenter,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                spreadRadius: 1.5,
                blurRadius: 15,
                offset: Offset(0, -1))
          ]),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  IconButton(
                      onPressed: () {
                        setState(() {
                          _selectedScreen = 0;
                        });
                        _pageController.jumpToPage(_selectedScreen);
                      },
                      icon: Image.asset(
                        currentIndex == 0
                            ? 'assets/icons/home-active.png'
                            : 'assets/icons/home.png',
                      )),
                  currentIndex == 0 ? const Text("Home") : const SizedBox()
                ],
              ),
              Column(
                children: [
                  IconButton(
                      onPressed: () {
                        setState(() {
                          _selectedScreen = 1;
                        });
                        _pageController.jumpToPage(_selectedScreen);
                      },
                      icon: Image.asset(
                        currentIndex == 1
                            ? 'assets/icons/leaderboard-active.png'
                            : 'assets/icons/leaderboard.png',
                      )),
                  currentIndex == 1
                      ? const Text("Leaderboard")
                      : const SizedBox()
                ],
              ),
              Column(
                children: [
                  IconButton(
                      onPressed: () {
                        setState(() {
                          _selectedScreen = 2;
                        });
                        _pageController.jumpToPage(_selectedScreen);
                      },
                      icon: Image.asset(
                        currentIndex == 2
                            ? 'assets/icons/profile-active.png'
                            : 'assets/icons/profile.png',
                      )),
                  currentIndex == 2 ? const Text("Profile") : const SizedBox()
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff7236ed),
      body: Stack(alignment: Alignment.bottomCenter, children: [
        PageView(
          physics: const BouncingScrollPhysics(),
          controller: _pageController,
          children: const [
            HomeScreen(),
            LeaderBoardScreen(),
            ProfileScreen(),
          ],
          onPageChanged: (pageIndex) {
            setState(() {
              _selectedScreen = pageIndex;
            });
          },
        ),
        bottomNavBar(context, _selectedScreen)
      ]),
    );
  }
}
