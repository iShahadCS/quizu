import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:quizu/providers/scores.dart';
import 'package:quizu/widgets/circle_button.dart';
import 'package:quizu/widgets/profile_image.dart';

import '../providers/auth.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Future pickImage(BuildContext context) async {
    try {
      final selectedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (selectedImage == null) {
        return;
      } else {
        final imageTemp = File(selectedImage.path);
        Provider.of<AuthProvider>(context, listen: false)
            .updateUserImage(imageTemp);
      }
    } on PlatformException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context);
    final currentUser = Provider.of<AuthProvider>(context).getCurrentUser;
    final userScores = Provider.of<ScoresProvider>(context).getUserScores;

    return Scaffold(
      backgroundColor: const Color(0xff7236ed),
      body: SizedBox(
        width: screenSize.size.width,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Align(
              alignment: Alignment.centerRight,
              child: Padding(
                  padding: EdgeInsets.only(
                      top: screenSize.viewPadding.top + 20, right: 25),
                  child: CircleButton(
                    onTap: () async {
                      await Provider.of<AuthProvider>(context, listen: false)
                          .logOut();
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pushReplacementNamed('/');
                    },
                    icon: Icons.logout,
                  ))),
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              ProfileImage(
                size: screenSize.size.height * 0.2,
              ),
              GestureDetector(
                onTap: () => pickImage(context),
                child: Container(
                  height: screenSize.size.height * 0.06,
                  width: screenSize.size.height * 0.06,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.edit,
                    color: Color(0xff140f5f),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            currentUser.name,
            style: const TextStyle(
                color: Colors.white, fontSize: 30, fontWeight: FontWeight.w800),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            currentUser.mobile,
            style: const TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
          ),
          const Spacer(),
          Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                color: Color(0xfff9f9fe)),
            height: screenSize.size.height < 700
                ? screenSize.size.height * 0.5 - screenSize.viewPadding.top
                : screenSize.size.height * 0.55 - screenSize.viewPadding.top,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("My Scores",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                  SizedBox(
                    height: screenSize.size.height < 700
                        ? screenSize.size.height * 0.4 -
                            screenSize.viewPadding.top
                        : screenSize.size.height * 0.45 -
                            screenSize.viewPadding.top,
                    child: userScores.isEmpty
                        ? const Padding(
                            padding: EdgeInsets.only(bottom: 95),
                            child: Center(
                                child: Text(
                              "You Have No Score For Now",
                              style: TextStyle(color: Colors.grey),
                            )),
                          )
                        : ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            padding:
                                const EdgeInsets.only(bottom: 100, top: 20),
                            itemCount: userScores.length,
                            itemBuilder: (ctx, i) => Column(
                                  children: [
                                    Container(
                                      height: 60,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          boxShadow: [
                                            BoxShadow(
                                                blurRadius: 7,
                                                color: Colors.grey[300]!)
                                          ]),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              userScores[i].timeStarted,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.grey[700]),
                                            ),
                                            Text(
                                              userScores[i]
                                                  .totalCorrectAnswers
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w700,
                                                  color: Color(0xffff9431)),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    )
                                  ],
                                )),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
