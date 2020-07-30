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
        child: Column(
          children: <Widget>[
            Stack(
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
                          diameterContainer:
                              MediaQuery.of(context).size.width / 2,
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
                        ProfileInfoCard(
                          cardTitle: 'Friends',
                          cardValue: 50,
                        ),
                        ProfileInfoCard(
                          cardTitle: 'Books',
                          cardValue: 16,
                        ),
                        ProfileInfoCard(
                          cardTitle: 'Wishlist',
                          cardValue: 24,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Expanded(
              child: Container(
                child: ListView(
                  padding: EdgeInsets.all(20.0),
                  children: <Widget>[
                    Container(
                      child: BioBox(),
                    )
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

class BioBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          height: 200.0,
          width: MediaQuery.of(context).size.width,
        ),
        Positioned(
          left: 40.0,
          child: Container(
            padding: EdgeInsets.only(left: 70.0, top: 30.0),
            height: 200.0,
            width: MediaQuery.of(context).size.width * 5 / 7,
            decoration: BoxDecoration(
              color: kNovelaBlue,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Bio:',
                  style: TextStyle(
                    color: kNovelaWhite,
                    fontFamily: 'RobotoSlab',
                    fontSize: 16.0,
                  ),
                ),
                Text(
                  'I Love the smell of a new Book!',
                  style: TextStyle(
                    color: kNovelaWhite,
                    fontFamily: 'RobotoSlab',
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  'Last Read:',
                  style: TextStyle(
                    color: kNovelaWhite,
                    fontFamily: 'RobotoSlab',
                    fontSize: 14.0,
                  ),
                ),
                Text(
                  'Murder on the Orient Express',
                  style: TextStyle(
                    color: kNovelaWhite,
                    fontFamily: 'RobotoSlab',
                    fontSize: 15.0,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 0.0,
          child: Container(
            height: 150.0,
            width: 100.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Image(
              image: AssetImage('images/book_cover.png'),
            ),
          ),
        ),
      ],
    );
  }
}
