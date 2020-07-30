import 'package:flutter/material.dart';
import 'package:novela/constants.dart';
import 'package:novela/screens/browse_screen.dart';
import 'package:novela/screens/registration_screen.dart';
import 'package:novela/widgets/registration_text_field.dart';
import '../widgets/double_bottom_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LogInScreen extends StatefulWidget {
  static const String id = 'log_in_screen';

  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final myPasswordController = TextEditingController();
  final myUsernameController = TextEditingController();

  final _auth = FirebaseAuth.instance;

  String _email;
  String _password;

  @override
  void initState() {
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
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Text(
                'novela',
                style: TextStyle(
                    color: kNovelaGreen,
                    fontSize: 90.0,
                    fontFamily: 'RobotoSlab'),
              ),
            ),
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
            DoubleBottomButtons(
              leftText: 'Back',
              onTapLeft: () {
                print('Username: $_email, Password: $_password');
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
              rightText: 'Log In',
              onTapRight: () async {
                try {
                  await _auth.signInWithEmailAndPassword(
                      email: _email, password: _password);
                } catch (e) {
                  print(e);
                }
                Navigator.pushNamed(context, BrowseScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
