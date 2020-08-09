import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:novela/backend/current_user_data.dart';
import 'package:novela/backend/shelf_data.dart';
import 'package:novela/components/book.dart';
import 'package:novela/components/shelf.dart';
import 'package:novela/constants.dart';
import 'package:novela/screens/browse_screen.dart';
import 'package:novela/screens/registration_screen.dart';
import 'package:novela/widgets/novela_leaf_logo.dart';
import 'package:novela/widgets/registration_text_field.dart';
import '../widgets/double_bottom_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LogInScreen extends StatefulWidget {
  static const String id = 'log_in_screen';

  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final myPasswordController = TextEditingController();
  final myUsernameController = TextEditingController();

  final _auth = FirebaseAuth.instance;
  final _firestore = Firestore.instance;

  String _email;
  String _password;

  List<Shelf> shelves;

  ShelfData shelfData;

  @override
  void initState() {
    super.initState();
    myUsernameController.addListener(_getInputText);
    myPasswordController.addListener(_getInputText);
    shelfData = ShelfData(firestore: _firestore);
  }

  @override
  void dispose() {
    myUsernameController.dispose();
    myPasswordController.dispose();
    super.dispose();
  }

  void _getInputText() {
    _email = myUsernameController.text;
    _password = myPasswordController.text;
  }

  @override
  Widget build(BuildContext context) {
    bool showSpin = false;

    return Scaffold(
      backgroundColor: kNovelaBlue,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 30.0,
            horizontal: 20.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 3,
                child: NovelaLeafLogo(),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  children: <Widget>[
                    RegistrationTextField(
                      hintText: 'Email',
                      controller: myUsernameController,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    RegistrationTextField(
                      hintText: 'Password',
                      isObscured: true,
                      controller: myPasswordController,
                    ),
                  ],
                ),
              ),
              DoubleBottomButtons(
                leftText: 'Back',
                onTapLeft: () {
                  print('Username: $_email, Password: $_password');
                  Navigator.pushNamed(context, RegistrationScreen.id);
                },
                rightText: 'Log In',
                onTapRight: () async {
                  setState(() {
                    showSpin = true;
                  });
                  try {
                    final user = await _auth.signInWithEmailAndPassword(
                        email: _email, password: _password);
                    if (user != null) {
                      await CurrentUserData().getProfilePictureURL();
                      shelves = await ShelfData(firestore: _firestore)
                          .getShelvesData();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BrowseScreen(
                            shelves: shelves,
                          ),
                        ),
                      );
                    }
                  } catch (e) {
                    print(e);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
