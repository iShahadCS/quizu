import 'package:flutter/material.dart';

//======================================================================

class OTPTextField extends StatelessWidget {
  final TextEditingController controller;
  const OTPTextField({Key? key, required this.controller}) : super(key: key);

//======================================================================

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        height: 60,
        width: 50,
        child: TextField(
          controller: controller,
          maxLength: 1,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black12)),
            counterText: '',
            // hintStyle: TextStyle(color: Colors.black, fontSize: 20.0),
          ),
          onChanged: (val) {
            if (val.length == 1) {
              FocusScope.of(context).nextFocus();
            }
          },
        ),
      ),
    );
  }
}
