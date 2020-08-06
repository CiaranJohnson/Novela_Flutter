import 'package:flutter/material.dart';
import 'package:novela/backend/initialise_new_user.dart';
import 'package:novela/constants.dart';
import 'package:novela/screens/browse_screen.dart';
import 'package:novela/screens/registration_screen.dart';
import 'package:novela/screens/user_info_screen.dart';
import 'package:novela/widgets/double_bottom_buttons.dart';
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
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
              rightText: 'Sign Up',
              onTapRight: () async {
                try {
                  final user = await _auth.createUserWithEmailAndPassword(
                      email: _email, password: _password);

                  if (user != null) {
                    await InitialiseNewUser().initNewUser();
                    print(user.toString());
                    Navigator.pushNamed(context, UserInfoScreen.id);
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
