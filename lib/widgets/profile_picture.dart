import 'package:flutter/material.dart';
import 'package:novela/constants.dart';

class ProfilePicture extends StatefulWidget {
  final double diameterContainer;
  final double radiusPicture;
  final bool innerBorder;
  final ImageProvider image;

  ProfilePicture(
      {this.diameterContainer,
      this.innerBorder = false,
      this.radiusPicture,
      this.image});

  @override
  _ProfilePictureState createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.diameterContainer,
      width: widget.diameterContainer,
      padding: EdgeInsets.all(4.0),
      child: Container(
        padding: widget.innerBorder ? EdgeInsets.all(4.0) : EdgeInsets.all(0.0),
        child: CircleAvatar(
          backgroundImage: widget.image,
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
