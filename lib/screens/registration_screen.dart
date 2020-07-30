import 'package:flutter/material.dart';
import 'package:novela/constants.dart';
import 'package:novela/screens/log_in_screen.dart';
import 'package:novela/screens/sign_up_screen.dart';

class RegistrationScreen extends StatelessWidget {
  static const String id = 'registration_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kNovelaBlue,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 100.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(bottom: 70.0),
                    child: Image(
                      height: 100.0,
                      width: 100.0,
                      image: AssetImage('images/leaf.png'),
                    ),
                  ),
                  Container(
                    child: Center(
                      child: Text(
                        'novela',
                        style: TextStyle(
                          color: kNovelaGreen,
                          fontFamily: 'RobotoSlab',
                          fontSize: 90.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, SignUpScreen.id);
                      },
                      color: kNovelaGreen,
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          color: kNovelaWhite,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, LogInScreen.id);
                      },
                      color: kNovelaGreen,
                      child: Text(
                        'Log In',
                        style: TextStyle(color: kNovelaWhite),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
