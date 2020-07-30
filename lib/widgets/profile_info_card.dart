import 'package:flutter/material.dart';
import 'package:novela/constants.dart';

class ProfileInfoCard extends StatelessWidget {
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
            'Friends',
            style: TextStyle(
              fontFamily: 'RobotoSlab',
              fontSize: 17.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            '50',
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
