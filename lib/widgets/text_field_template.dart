import 'package:flutter/material.dart';

//======================================================================

class FilledTextField extends StatelessWidget {
  final String hint;
  final Widget icon;
  final Function? validationFunction;
  final Function? onSavedFunction;
  final Function? onChangedFunction;
  final Function? onTapFunction;
  final bool isPassword;
  final FocusNode? focusNode;
  final TextEditingController? controller;

  const FilledTextField(
      {Key? key,
      this.controller,
      required this.hint,
      required this.icon,
      this.onTapFunction,
      this.focusNode,
      this.onChangedFunction,
      this.onSavedFunction,
      this.validationFunction,
      required this.isPassword})
      : super(key: key);

//------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 1,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ]),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        onTap: () => onTapFunction,
        onSaved: (value) => onSavedFunction!(value),
        validator: (value) => validationFunction!(value),
        onChanged: (value) =>
            onChangedFunction == null ? {} : onChangedFunction!(value),
        obscureText: isPassword ? true : false,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          prefixIcon: icon,
          hintText: hint,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              style: BorderStyle.none,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              style: BorderStyle.none,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.red),
          ),
          errorStyle: const TextStyle(
            color: Colors.transparent,
            fontSize: 0,
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.red),
          ),
        ),
      ),
    );
  }
}
