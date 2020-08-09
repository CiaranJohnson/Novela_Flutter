import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class InitialiseNewUser {
//  initalise friends, books and wishlist to zero
  final _firestore = Firestore.instance;
  final auth = FirebaseAuth.instance;
  FirebaseUser user;

  Future initNewUser() async {
    user = await auth.currentUser();
    Map<String, int> userInfo = {'Friends': 0, 'Books': 0, 'Wishlist': 0};
    _firestore
        .collection('User')
        .document(user.uid)
        .collection('Info')
        .document('profile_stats')
        .setData(userInfo);
  }

  Future addProfilePicture(String profilePicURL) async {
    user = await auth.currentUser();
    Map<String, String> userInfo = {'profile_pic': profilePicURL};
    _firestore
        .collection('User')
        .document(user.uid)
        .collection('Info')
        .document('profile_pic')
        .setData(userInfo);
  }
}
