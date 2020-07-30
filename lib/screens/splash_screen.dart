import 'package:flutter/material.dart';
import 'package:novela/constants.dart';

class SplashScreen extends StatelessWidget {
  static const String id = 'splash_screen';
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kNovelaGreen,
      child: Center(
        child: Text(
          'novela',
          style: TextStyle(),
        ),
      ),
    );
  }
}
