import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CurrentUserData {
  final _auth = FirebaseAuth.instance;
  final _firestore = Firestore.instance;
  FirebaseUser _user;

  CurrentUserData();

  void getFriendsNum() async {
    _user = await _auth.currentUser();
    _firestore
        .collection('User')
        .document(_user.uid)
        .collection('Info')
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) => print('${f.data}}'));
    });
  }

  int getWatchlistNum() {}

  int getSellBooksNum() {}

  Future<String> getCurrentUserName() async {
    _user = await _auth.currentUser();
    return _user.displayName;
  }

  Future getProfilePictureURL() async {
    _user = await _auth.currentUser();
    QuerySnapshot snapshot = await _firestore
        .collection('User')
        .document(_user.uid)
        .collection('Info')
        .getDocuments();

    for (DocumentSnapshot ds in snapshot.documents) {
      print(ds.data);
    }
  }
}
