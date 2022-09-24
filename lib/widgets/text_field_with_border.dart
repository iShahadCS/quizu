import 'package:flutter/material.dart';

//======================================================================

class TextFieldWithBorder extends StatelessWidget {
  final String title;
  final int lines;
  final Function? onSavedFunction;
  final bool isPassword;
  final TextEditingController? controller;
  final bool isNumber;
  final Function(String)? onChangedFunction;
  final bool? isError;

  const TextFieldWithBorder(
      {Key? key,
      this.controller,
      // this.validationFunction,
      this.onChangedFunction,
      this.isError,
      required this.isNumber,
      required this.isPassword,
      required this.title,
      required this.lines,
      this.onSavedFunction})
      : super(key: key);

//------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          onChanged: (value) =>
              onChangedFunction == null ? {} : onChangedFunction!(value),
          keyboardType: isNumber ? TextInputType.number : null,
          controller: controller,
          // validator: (value) => validationFunction!(value!),
          onSaved: (value) =>
              onSavedFunction == null ? {} : onSavedFunction!(value),
          obscureText: isPassword ? true : false,
          maxLines: lines,
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(fontSize: 18, fontWeight: FontWeight.w400),
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                  style: BorderStyle.solid,
                  color: isError != null && isError == true
                      ? Colors.red
                      : Colors.black26),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                  style: BorderStyle.solid,
                  color: isError != null && isError == true
                      ? Colors.red
                      : Colors.black26),
            ),
          ),
        )
      ],
    );
  }
}
