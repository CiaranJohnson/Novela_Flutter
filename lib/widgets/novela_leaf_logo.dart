import 'package:flutter/material.dart';
import '../constants.dart';

class NovelaLeafLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
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
    );
  }
}
