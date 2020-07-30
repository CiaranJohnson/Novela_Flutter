import 'package:flutter/material.dart';
import '../constants.dart';

class DoubleBottomButtons extends StatelessWidget {
  final String rightText;
  final String leftText;
  final Function onTapLeft;
  final Function onTapRight;

  DoubleBottomButtons(
      {@required this.leftText,
      @required this.rightText,
      @required this.onTapLeft,
      @required this.onTapRight});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: RaisedButton(
            onPressed: onTapLeft,
            color: kNovelaGreen,
            child: Text(
              this.leftText,
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
            onPressed: onTapRight,
            color: kNovelaGreen,
            child: Text(
              this.rightText,
              style: TextStyle(color: kNovelaWhite),
            ),
          ),
        ),
      ],
    );
  }
}
