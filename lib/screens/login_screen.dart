import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:phone_number/phone_number.dart';
import 'package:quizu/widgets/button.dart';
import 'package:quizu/widgets/otp.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart' as phone;
//==============================================================================

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

//==============================================================================

class _LoginScreenState extends State<LoginScreen> {
  ///input variables
  String mobile = '';
  final TextEditingController input = TextEditingController();

  ///error variables
  bool isMobileError = false;

  ///didChangeDependencies variables
  bool isinit = true;
  // ignore: prefer_typing_uninitialized_variables
  var argument;

//---------------------------------------------------------

  @override
  void didChangeDependencies() {
    if (isinit) {
      argument = ModalRoute.of(context)!.settings.arguments;
    }
    if (argument != null) {
      input.text = argument['mobile'];
    }
    isinit = false;
    super.didChangeDependencies();
  }

//---------------------------------------------------------

  void _submit(BuildContext context) async {
    bool isValid = await PhoneNumberUtil().validate(mobile, regionCode: 'SA');
    if (isValid == false) {
      setState(() {
        isMobileError = true;
      });
      return;
    } else {
      showModalBottomSheet(
        isScrollControlled: true,
        isDismissible: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15))),
        context: context,
        builder: (ctx) => OTP(mobile: mobile),
      );
    }
  }

//---------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final topPadding = MediaQuery.of(context).viewPadding.top;
    return Scaffold(
      backgroundColor: const Color(0xff7236ed),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ///image in the top of the screen --------------
              Container(
                height: screenSize.height >= 700
                    ? screenSize.height * 0.5
                    : screenSize.height * 0.4,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xfff3edff),
                ),
                child: Image.asset(
                  'assets/images/sign-in.png',
                  fit: BoxFit.fitHeight,
                ),
              ),

              ///form ---------------------------------------
              Container(
                height: screenSize.height >= 700
                    ? screenSize.height * 0.5 - topPadding
                    : screenSize.height * 0.6 - topPadding,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xff7236ed),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "👋🏻 Hey, Login to",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text(
                        "QuizU",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text('Mobile',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w400)),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white),
                        child: InternationalPhoneNumberInput(
                          textFieldController: input,
                          keyboardType: const TextInputType.numberWithOptions(
                              signed: true, decimal: true),
                          spaceBetweenSelectorAndTextField: 0,
                          inputBorder: InputBorder.none,
                          selectorConfig: const SelectorConfig(
                              leadingPadding: 10,
                              selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                              showFlags: true,
                              setSelectorButtonAsPrefixIcon: true),
                          initialValue: phone.PhoneNumber(
                              phoneNumber: "+966",
                              dialCode: "+966",
                              isoCode: "SA"),
                          onInputChanged: (val) {
                            mobile = val.phoneNumber ?? "";
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),

                      /// input errors ui -------------------

                      argument != null
                          ? const Text(
                              "The phone number is used, try another one",
                              style: TextStyle(color: Colors.white),
                            )
                          : const SizedBox(),
                      isMobileError
                          ? const Text(
                              "Please enter a valid number",
                              style: TextStyle(color: Colors.white),
                            )
                          : const SizedBox(),
                      const SizedBox(
                        height: 10,
                      ),
                      Button(
                        onSubmitFunction: () => _submit(context),
                        text: "Start",
                        color: const Color(0xff140f5f),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
