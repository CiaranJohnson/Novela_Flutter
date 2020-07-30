import 'package:flutter/material.dart';
import 'package:novela/constants.dart';

class ProfilePicture extends StatelessWidget {
  final double diameterContainer;
  final double radiusPicture;
  final bool innerBorder;

  ProfilePicture(
      {this.diameterContainer, this.innerBorder = false, this.radiusPicture});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: diameterContainer,
      width: diameterContainer,
      padding: EdgeInsets.all(4.0),
      child: Container(
        padding: innerBorder ? EdgeInsets.all(4.0) : EdgeInsets.all(0.0),
        child: CircleAvatar(
          backgroundImage: AssetImage('images/dog_pic.JPG'),
        ),
        decoration: BoxDecoration(
          color: kNovelaWhite,
          shape: BoxShape.circle,
        ),
      ),
      decoration: BoxDecoration(
        color: kPictureBorder,
        shape: BoxShape.circle,
      ),
    );
  }
}
