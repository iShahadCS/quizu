import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:quizu/models/http_exception.dart';
import 'package:quizu/providers/questions.dart';
import 'package:quizu/providers/scores.dart';
import 'package:quizu/screens/login_screen.dart';
import 'package:quizu/screens/name_screen.dart';
import 'package:quizu/screens/navbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../providers/auth.dart';

//==============================================================================

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  static const routeName = '/loading';

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

//==============================================================================

class _LoadingScreenState extends State<LoadingScreen> {
  Map argument = {};

  ///which method should be invoked? ---------------------------------------
  @override
  void didChangeDependencies() {
    ///{"screen": "login", rest of arguments that should be passed in the function}
    argument = ModalRoute.of(context)!.settings.arguments != null
        ? ModalRoute.of(context)!.settings.arguments as Map
        : {};
    if (argument != {} && argument['screen'] == "login") {
      loginSubmit();
    } else if (argument != {} && argument['screen'] == "name") {
      nameSubmit();
    } else if (argument != {} && argument['screen'] == "logout") {
      Future.delayed(const Duration(milliseconds: 800), () {
        logOut();
      });
    }
    super.didChangeDependencies();
  }

  ///login screen api function  --------------------------------------------
  void loginSubmit() async {
    try {
      final bool status =
          await Provider.of<AuthProvider>(context, listen: false)
              .logIn(argument['mobile'], argument['otp']);
      // ignore: use_build_context_synchronously
      if (status == true) {
        Navigator.of(context).pushReplacementNamed(NameScreen.routeName);
      } else {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(NavBar.routeName, (route) => false);
      }
    } on HttpException catch (_) {
      Navigator.of(context).pushReplacementNamed(LoginScreen.routeName,
          arguments: {"mobile": argument['mobile'], "err": true});
    }
  }

  ///name screen api function  --------------------------------------------
  void nameSubmit() async {
    try {
      final localStorage = await SharedPreferences.getInstance();
      final token = localStorage.getString("token")!;
      // ignore: use_build_context_synchronously
      await Provider.of<AuthProvider>(context, listen: false)
          .name(token, argument['name']);
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacementNamed(NavBar.routeName);
    } catch (_) {}
  }

//---------------------------------------------------------

  void logOut() async {
    Provider.of<QuestionsProvider>(context, listen: false).logOut;
    Provider.of<ScoresProvider>(context, listen: false).logOut;
    await Provider.of<AuthProvider>(context, listen: false).logOut();
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacementNamed('/');
  }

//---------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SpinKitFoldingCube(color: Color(0xff7236ed)),
    );
  }
}
