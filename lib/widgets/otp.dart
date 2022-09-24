import 'package:flutter/material.dart';
import 'package:quizu/screens/loading_screen.dart';
import 'package:quizu/widgets/button.dart';
import './otp_textfield.dart';

//==============================================================================

class OTP extends StatefulWidget {
  final String mobile;
  const OTP({super.key, required this.mobile});

  @override
  State<OTP> createState() => _OTPState();
}

//==============================================================================

class _OTPState extends State<OTP> {
  /// inputs controllers
  final input1 = TextEditingController();
  final input2 = TextEditingController();
  final input3 = TextEditingController();
  final input4 = TextEditingController();

  /// ui variables
  bool isOTPError = false;

//---------------------------------------------------------

  void _otpSubmit() {
    final code = input1.text + input2.text + input3.text + input4.text;

    if (code != "0000") {
      setState(() {
        isOTPError = true;
      });
      return;
    }
    Navigator.of(context).pushNamed(LoadingScreen.routeName,
        arguments: {"screen": "login", "mobile": widget.mobile, "otp": code});
  }

//---------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return SizedBox(
      height: MediaQuery.of(context).viewInsets.bottom == 0.0
          ? screenSize.height * 0.7
          : screenSize.height * 0.5 + MediaQuery.of(context).viewInsets.bottom,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50),
        child: ListView(
          children: [
            Text(
              textAlign: TextAlign.center,
              'Please check your mobile',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'We have sent an OTP to your number',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OTPTextField(controller: input1),
                OTPTextField(controller: input2),
                OTPTextField(controller: input3),
                OTPTextField(controller: input4),
              ],
            ),
            isOTPError
                ? Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Text(
                      'The OTP is wrong, try again',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: Colors.redAccent),
                    ),
                  )
                : const SizedBox(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              child: Button(
                  onSubmitFunction: () => _otpSubmit(),
                  text: "Check",
                  color: const Color(0xff3923d0)),
            )
          ],
        ),
      ),
    );
  }
}
