import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizu/providers/auth.dart';
import 'package:quizu/providers/questions.dart';
import 'package:quizu/providers/scores.dart';
import 'package:quizu/screens/loading_screen.dart';
import 'package:quizu/screens/login_screen.dart';
import 'package:quizu/screens/name_screen.dart';
import 'package:quizu/screens/navbar.dart';
import 'package:quizu/screens/quiz.dart';
import 'package:quizu/screens/win_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (ctx) => AuthProvider()),
          ChangeNotifierProvider(create: (ctx) => QuestionsProvider()),
          ChangeNotifierProvider(create: (ctx) => ScoresProvider())
        ],
        child: Consumer<AuthProvider>(
          builder: (context, authProvider, _) {
            return MaterialApp(
              title: 'QuizU',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: FutureBuilder(
                future: authProvider.tryAutoLogin(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return const LoadingScreen();
                  } else if (snapshot.data == true) {
                    return const NavBar();
                  } else {
                    return const LoginScreen();
                  }
                },
              ),
              // home: const Quiz(),
              routes: {
                LoadingScreen.routeName: (context) => const LoadingScreen(),
                LoginScreen.routeName: (context) => const LoginScreen(),
                NameScreen.routeName: (context) => const NameScreen(),
                NavBar.routeName: (context) => const NavBar(),
                Quiz.routeName: (context) => const Quiz(),
                WinScreen.routeName: (context) => const WinScreen()
              },
            );
          },
        ));
  }
}
