import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:novela/constants.dart';
import 'package:novela/screens/browse_screen.dart';
import 'package:novela/screens/registration_screen.dart';
import 'package:novela/widgets/double_bottom_buttons.dart';
import 'package:novela/widgets/registration_text_field.dart';

class UserInfoScreen extends StatefulWidget {
  static const String id = 'user_info_screen';

  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  final _auth = FirebaseAuth.instance;
  final myDisplayNameController = TextEditingController();

  String _name;
  FirebaseUser _user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myDisplayNameController.addListener(_getInputText);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    myDisplayNameController.dispose();
    super.dispose();
  }

  void _getInputText() {
    _name = myDisplayNameController.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kNovelaBlue,
      body: Container(
        padding: EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Center(
              child: Text(
                'novela',
                style: TextStyle(
                  color: kNovelaGreen,
                  fontSize: 100.0,
                  fontFamily: 'RobotoSlab',
                ),
              ),
            ),
            RegistrationTextField(
              hintText: 'Name',
              controller: myDisplayNameController,
            ),
            DoubleBottomButtons(
              leftText: 'Back',
              onTapLeft: () {
                Navigator.pushNamed(
                  context,
                  RegistrationScreen.id,
                );
              },
              rightText: 'Next',
              onTapRight: () async {
                try {
                  _user = await _auth.currentUser();
                  UserUpdateInfo userInfo = UserUpdateInfo();
                  userInfo.displayName = _name;
                  await _user.updateProfile(userInfo);
                  await _user.reload();

                  if (_user.displayName != null) {
                    Navigator.pushNamed(context, BrowseScreen.id);
                  }
                } catch (e) {
                  print(e);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
