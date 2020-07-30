import 'package:firebase_auth/firebase_auth.dart';

class CurrentUser {
  final _auth = FirebaseAuth.instance;
//  final FirebaseUser loggedInUser;
  final String name;
  CurrentUser({this.name});

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        final _loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

//  String get userDisplayName => loggedInUser.displayName;
}
