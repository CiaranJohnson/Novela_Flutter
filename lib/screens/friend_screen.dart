import 'dart:io';
import 'package:flutter/material.dart';
import 'package:novela/backend/friends_backend.dart';
import 'package:novela/constants.dart';
import 'package:novela/screens/profile_screen.dart';
import 'package:novela/widgets/profile_picture.dart';

class FriendScreen extends StatefulWidget {
  static const String id = "friend_screen";
  final ImageProvider profilePic;

  FriendScreen({this.profilePic});
  @override
  _FriendScreenState createState() => _FriendScreenState();
}

class _FriendScreenState extends State<FriendScreen> {
  final friendSearchController = TextEditingController();
  String friendImage;
  String friendName;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFriends();
    friendSearchController.addListener(_getInputText);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    friendSearchController.dispose();
    super.dispose();
  }

  void _getInputText() {
    setState(() {
      friendName = friendSearchController.text;
    });
  }

  void getFriends() async {
    List<String> profilePics = await FriendsBackend().findAllUsersProfilePics();
    setState(() {
      if (profilePics.length > 0) {
        friendImage = profilePics[0];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kNovelaWhite,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 50.0),
            height: 180.0,
            width: double.infinity,
            decoration: BoxDecoration(
              color: kNovelaGreen,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    left: 10.0,
                    right: 5.0,
                  ),
                  child: ProfilePicture(
                    diameterContainer: 90.0,
                    image: widget.profilePic,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 15.0,
                      ),
                      child: Text(
                        'novela',
                        style: TextStyle(
                          fontSize: 30.0,
                          color: kNovelaWhite,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'RobotoSlab',
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 10.0),
                      child: Text(
                        ' Your Friends',
                        style: TextStyle(
                          color: kNovelaWhite,
                          fontFamily: 'RobotoSlab',
                          fontSize: 31.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 10.0,
                ),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(
                    context,
                    ProfileScreen.id,
                  ),
                  child: CircleAvatar(
                    child: Platform.isIOS
                        ? Icon(
                            Icons.arrow_back_ios,
                            color: kNovelaBlue,
                          )
                        : Icon(
                            Icons.arrow_back,
                            color: kNovelaBlue,
                          ),
                    backgroundColor: Color(0xFFE5E6E4),
                    radius: 20.0,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 5.0,
                    ),
                    child: TextField(
                      controller: friendSearchController,
                      cursorColor: kNovelaGreen,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: kNovelaGreen,
                      ),
                      decoration: InputDecoration(
                        fillColor: Color(0xFFE5E6E4),
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide(
                            color: Color(0xFFE5E6E4),
                            width: 5.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide(
                              color: Color(0xFFE5E6E4),
                              width: 3.0,
                            )),
                        labelText: 'Find Friends...',
                        labelStyle: TextStyle(color: kNovelaBlue),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(),
          Expanded(
            child: Scrollbar(
              child: ListView(
                children: <Widget>[
                  FriendCard(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FriendCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 15.0,
          ),
          ProfilePicture(
            diameterContainer: 70.0,
            image: AssetImage('images/dog_pic.JPG'),
          ),
          SizedBox(
            width: 15.0,
          ),
          Text(
            'Ciaran Johnson',
            style: TextStyle(fontSize: 30.0, color: kPictureBorder),
          )
        ],
      ),
    );
  }
}
