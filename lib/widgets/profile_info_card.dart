import 'package:flutter/material.dart';
import 'package:novela/constants.dart';

class ProfileInfoCard extends StatelessWidget {
  final String cardTitle;
  final String cardValue;
  ProfileInfoCard({this.cardTitle, this.cardValue});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 1.0),
      height: 125.0,
      width: 98.0,
      decoration: BoxDecoration(
        color: kPictureBorder,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: kNovelaWhite,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            cardTitle,
            style: TextStyle(
              fontFamily: 'RobotoSlab',
              fontSize: 17.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            cardValue.toString(),
            style: TextStyle(
              fontFamily: 'RobotoSlab',
              fontSize: 40.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
