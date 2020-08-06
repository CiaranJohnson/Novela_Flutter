import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class InitialiseNewUser {
//  initalise friends, books and wishlist to zero
  final _firestore = Firestore.instance;
  final auth = FirebaseAuth.instance;
  FirebaseUser user;

  void initNewUser() async {
    user = await auth.currentUser();
    user.uid;
    Map<String, int> userInfo = {'Friends': 0, 'Books': 0, 'Wishlist': 0};
    _firestore
        .collection('User')
        .document(user.uid)
        .collection('Info')
        .add(userInfo);
  }
}
