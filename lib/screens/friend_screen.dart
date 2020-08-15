import 'package:flutter/material.dart';
import 'package:novela/backend/friends_backend.dart';
import 'package:novela/components/book.dart';
import 'package:novela/constants.dart';
import 'package:novela/widgets/profile_picture.dart';
import 'package:novela/widgets/registration_text_field.dart';

class FriendScreen extends StatefulWidget {
  static const String id = "friend_screen";
  final ImageProvider profilePic;

  FriendScreen({this.profilePic});
  @override
  _FriendScreenState createState() => _FriendScreenState();
}

class _FriendScreenState extends State<FriendScreen> {
  String friendImage;
  String friendName;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFriends();
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
          Container(
            height: 150.0,
            width: 100.0,
            decoration: BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                  image: friendImage == null
                      ? AssetImage('images/leaf.png')
                      : NetworkImage(friendImage),
                  fit: BoxFit.cover),
            ),
            margin: EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 5.0,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 60.0),
            child: TextField(
              onChanged: (value) => friendName = value,
              cursorColor: kNovelaWhite,
              textAlign: TextAlign.center,
              style: TextStyle(color: kNovelaWhite),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: kNovelaGreen,
                    width: 5.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: kNovelaGreen,
                    width: 3.0,
                  ),
                ),
                labelText: 'Find Friends...',
                labelStyle: TextStyle(color: kNovelaBlue),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
