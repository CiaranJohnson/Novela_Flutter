import 'package:flutter/material.dart';
import 'package:novela/constants.dart';
import 'package:novela/widgets/profile_info_card.dart';
import 'package:novela/widgets/profile_picture.dart';
import 'package:bordered_text/bordered_text.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatelessWidget {
  static const String id = 'profile_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kNovelaWhite,
      body: Container(
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height / 2 + 100,
              color: kNovelaWhite,
            ),
            Container(
              height: MediaQuery.of(context).size.height / 2,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment
                      .bottomCenter, // 10% of the width, so there are ten blinds.
                  colors: [
                    kNovelaBlue,
                    kNovelaGreen,
                  ], // whitish to gray
                  tileMode: TileMode.repeated,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: BorderedText(
                        strokeWidth: 1.0,
                        strokeColor: kTextBorder,
                        child: Text(
                          'novela',
                          style: TextStyle(
                            color: kNovelaWhite,
                            fontSize: 30.0,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'RobotoSlab',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 20,
                    ),
                    ProfilePicture(
                      diameterContainer: MediaQuery.of(context).size.width / 2,
                      innerBorder: true,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'Ciaran Johnson',
                      style: TextStyle(
                          color: kNovelaWhite,
                          fontSize: 30.0,
                          fontFamily: 'RobotoSlab',
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0.0,
              child: Container(
                height: 150.0,
                width: 300.0,
                child: Row(
                  children: <Widget>[
                    ProfileInfoCard(),
                    ProfileInfoCard(),
                    ProfileInfoCard(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
