import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizu/providers/scores.dart';

class LeaderBoardScreen extends StatelessWidget {
  const LeaderBoardScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final leaderboardList =
        Provider.of<ScoresProvider>(context).getLeaderBoardScores;
    final screenSize = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: const Color(0xff7236ed),
      body: SizedBox(
          height: screenSize.size.height,
          child: Column(children: [
            Expanded(
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(
                      top: 35, bottom: 100, left: 25, right: 25),
                  itemCount: 10,
                  itemBuilder: (ctx, i) => Column(
                        children: [
                          SizedBox(
                            height: screenSize.size.height * 0.1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CircleAvatar(
                                    backgroundColor: const Color(0xffff9431),
                                    radius: 25,
                                    child: Text(
                                      (i + 1).toString(),
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 30,
                                          fontWeight: FontWeight.w800),
                                    )),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  leaderboardList[i].name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 23,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  leaderboardList[i].score.toString().length > 3
                                      ? leaderboardList[i]
                                          .score
                                          .toString()
                                          .substring(0, 2)
                                      : leaderboardList[i].score.toString(),
                                  overflow: TextOverflow.fade,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 23,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                          const Divider(),
                          const SizedBox(
                            height: 15,
                          )
                        ],
                      )),
            )
          ])),
    );
  }
}
