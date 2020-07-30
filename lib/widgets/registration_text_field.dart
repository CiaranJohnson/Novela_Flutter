import 'package:flutter/material.dart';
import '../constants.dart';

class RegistrationTextField extends StatelessWidget {
  final String hintText;
  final bool isObscured;
  final controller;

  RegistrationTextField({
    @required this.hintText,
    this.isObscured = false,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isObscured,
      controller: controller,
      cursorColor: kNovelaWhite,
      textAlign: TextAlign.center,
      style: TextStyle(color: kNovelaWhite),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: kNovelaGreen,
            width: 5.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: kNovelaGreen,
            width: 3.0,
          ),
        ),
        labelText: hintText,
        labelStyle: TextStyle(color: kNovelaWhite),
      ),
    );
  }
}
