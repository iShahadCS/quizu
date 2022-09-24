import 'package:flutter/material.dart';
import 'package:quizu/screens/loading_screen.dart';
import 'package:quizu/widgets/button.dart';
import 'package:quizu/widgets/text_field_with_border.dart';

class NameScreen extends StatefulWidget {
  const NameScreen({super.key});
  static const routeName = '/name';

  @override
  State<NameScreen> createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  String name = '';
  bool isNameError = false;

  void submit() {
    if (name.trim() == '') {
      setState(() {
        isNameError = true;
      });
      return;
    } else {
      Navigator.of(context).pushReplacementNamed(LoadingScreen.routeName,
          arguments: {"screen": "name", "name": name});
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenSize.height,
          width: screenSize.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(top: screenSize.height * 0.1, bottom: 20),
                  child: Image.asset(
                    'assets/images/name.png',
                  ),
                ),
                const Text(
                  "What's Your Name?",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFieldWithBorder(
                    isNumber: false,
                    isPassword: false,
                    title: "",
                    lines: 1,
                    isError: isNameError,
                    onChangedFunction: (val) {
                      name = val;
                    }),
                const SizedBox(
                  height: 5,
                ),
                isNameError
                    ? const Text(
                        "Please enter your name",
                        style: TextStyle(color: Colors.redAccent, fontSize: 16),
                      )
                    : const SizedBox(),
                const SizedBox(
                  height: 15,
                ),
                Button(
                    onSubmitFunction: () => submit(),
                    text: "Done",
                    color: const Color(0xff140f5f))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
