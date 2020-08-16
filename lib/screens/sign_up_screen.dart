import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:novela/backend/initialise_new_user.dart';
import 'package:novela/backend/shelf_data.dart';
import 'package:novela/components/shelf.dart';
import 'package:novela/constants.dart';
import 'package:novela/screens/browse_screen.dart';
import 'package:novela/screens/registration_screen.dart';
import 'package:novela/screens/user_info_screen.dart';
import 'package:novela/widgets/double_bottom_buttons.dart';
import 'package:novela/widgets/novela_leaf_logo.dart';
import '../widgets/registration_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreen extends StatefulWidget {
  static const String id = 'sign_up_screen';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final myPasswordController = TextEditingController();
  final myUsernameController = TextEditingController();

  final _auth = FirebaseAuth.instance;

  String _email;
  String _password;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myUsernameController.addListener(_getInputText);
    myPasswordController.addListener(_getInputText);
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
                  Navigator.pushNamed(context, RegistrationScreen.id);
                },
                rightText: 'Sign Up',
                onTapRight: () async {
                  try {
                    final user = await _auth.createUserWithEmailAndPassword(
                        email: _email, password: _password);

                    if (user != null) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => UserInfoScreen(),
                        ),
                      );
                    }
                  } catch (e) {
                    print(e);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
