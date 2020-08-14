import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:novela/backend/firebase_storage_manager.dart';
import 'package:novela/backend/initialise_new_user.dart';
import 'package:novela/backend/shelf_data.dart';
import 'package:novela/components/shelf.dart';
import 'package:novela/constants.dart';
import 'package:novela/screens/browse_screen.dart';
import 'package:novela/screens/registration_screen.dart';
import 'package:novela/widgets/double_bottom_buttons.dart';
import 'package:novela/widgets/novela_leaf_logo.dart';
import 'package:novela/widgets/profile_picture.dart';
import 'package:novela/widgets/registration_text_field.dart';
import 'package:image_picker/image_picker.dart';

class UserInfoScreen extends StatefulWidget {
  static const String id = 'user_info_screen';

  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  String _firstName;
  String _lastName;

  final myFirstNameController = TextEditingController();
  final myLastNameController = TextEditingController();

  Firestore _firestore = Firestore.instance;
  List<Shelf> shelves;

  Future<PickedFile> imageFile;
  FileImage profilePic;
  File _profilePicFile;
  String _profilePicURL;

  FirebaseStorageManager _firebaseStorageManager = FirebaseStorageManager();

  InitialiseNewUser initNewUser = InitialiseNewUser();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myFirstNameController.addListener(_getInputText);
    myLastNameController.addListener(_getInputText);
  }

  void _getInputText() {
    _firstName = myFirstNameController.text;
    _lastName = myLastNameController.text;
  }

  @override
  void dispose() {
    myFirstNameController.dispose();
    myLastNameController.dispose();
    super.dispose();
  }

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
          _profilePicFile = File(snapshot.data.path);
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
            image: AssetImage('images/leaf.png'),
          );
        } else {
          return ProfilePicture(
            diameterContainer: MediaQuery.of(context).size.width / 2,
            innerBorder: true,
            image: AssetImage('images/leaf.png'),
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
            NovelaLeafLogo(),
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
                  controller: myFirstNameController,
                ),
                SizedBox(
                  height: 10.0,
                ),
                RegistrationTextField(
                  hintText: 'Last Name',
                  controller: myLastNameController,
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
                  if (_firstName != null && _firstName.length > 0) {
                    _profilePicURL = await initNewUser.createNewUser(_firstName,
                        _lastName, _profilePicFile, _firebaseStorageManager);
                    shelves =
                        await ShelfData(firestore: _firestore).getShelvesData();
                    if (shelves != null) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BrowseScreen(
                            shelves: shelves,
                            profilePicURL: _profilePicURL,
                          ),
                        ),
                      );
                    } else {
                      if (shelves == null) {
                        print('Shelves not loaded');
                      } else {
                        print('Display Name is null');
                      }
                    }
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
