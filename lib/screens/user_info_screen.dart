import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:novela/backend/shelf_data.dart';
import 'package:novela/components/shelf.dart';
import 'package:novela/constants.dart';
import 'package:novela/screens/browse_screen.dart';
import 'package:novela/screens/registration_screen.dart';
import 'package:novela/widgets/double_bottom_buttons.dart';
import 'package:novela/widgets/profile_picture.dart';
import 'package:novela/widgets/registration_text_field.dart';
import 'package:image_picker/image_picker.dart';

class UserInfoScreen extends StatefulWidget {
  static const String id = 'user_info_screen';

  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  String _name;
  final _auth = FirebaseAuth.instance;
  FirebaseUser _user;

  List<Shelf> shelves;

  Firestore _firestore = Firestore.instance;

  Future<PickedFile> imageFile;

  FileImage profilePic;

  void pickImageFromGallery(ImageSource source) {
    setState(() {
      imageFile = ImagePicker().getImage(source: source);
    });
  }

  Widget showImage() {
    return FutureBuilder<PickedFile>(
      future: imageFile,
      builder: (BuildContext context, AsyncSnapshot<PickedFile> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          print("Photo");
          return ProfilePicture(
            diameterContainer: MediaQuery.of(context).size.width / 2,
            innerBorder: true,
            image: FileImage(File(snapshot.data.path)),
          );
        } else if (snapshot.error != null) {
          print('Error');
          return ProfilePicture(
            diameterContainer: MediaQuery.of(context).size.width / 2,
            innerBorder: true,
            image: AssetImage('images/dog_pic.JPG'),
          );
        } else {
          return ProfilePicture(
            diameterContainer: MediaQuery.of(context).size.width / 2,
            innerBorder: true,
            image: AssetImage('images/dog_pic.JPG'),
          );
        }
      },
    );
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
            GestureDetector(
              onTap: () {
                pickImageFromGallery(ImageSource.gallery);
              },
              child: showImage(),
            ),
            Column(
              children: <Widget>[
                RegistrationTextField(
                  hintText: 'First Name',
                ),
                SizedBox(
                  height: 10.0,
                ),
                RegistrationTextField(
                  hintText: 'Last Name',
                ),
              ],
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

                  shelves =
                      await ShelfData(firestore: _firestore).getShelvesData();
                  if (shelves != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BrowseScreen(
                          shelves: shelves,
                        ),
                      ),
                    );
                  }

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
