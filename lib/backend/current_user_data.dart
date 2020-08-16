import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CurrentUserData {
  final _auth = FirebaseAuth.instance;
  final _firestore = Firestore.instance;
  FirebaseUser _user;

  CurrentUserData();

  Future<String> getCurrentUserName() async {
    _user = await _auth.currentUser();
    return _user.displayName;
  }

  Future<int> getPersonalInfo(String infoType) async {
    _user = await _auth.currentUser();
    DocumentSnapshot snapshot = await _firestore
        .collection('User')
        .document(_user.uid)
        .collection('Info')
        .document('profile_stats')
        .get();
    return snapshot[infoType];
  }

  Future getProfilePictureURL() async {
    String profilePicURL;
    _user = await _auth.currentUser();
    QuerySnapshot snapshot = await _firestore
        .collection('User')
        .document(_user.uid)
        .collection('Info')
        .getDocuments();

    for (DocumentSnapshot ds in snapshot.documents) {
      if (ds.data.containsKey("profile_pic")) {
        profilePicURL = ds.data["profile_pic"];
      }
    }
    return profilePicURL;
  }

  Future<int> getUserInfo(String info) async {
    _user = await _auth.currentUser();
    DocumentSnapshot ds = await _firestore
        .collection('User')
        .document(_user.uid)
        .collection('Info')
        .document('profile_stats')
        .get();
    return ds.data[info];
  }

  Future incrementUserInfo(String info) async {
    _user = await _auth.currentUser();
    int infoCount = await getUserInfo(info);
    await _firestore
        .collection('User')
        .document(_user.uid)
        .collection('Info')
        .document('profile_stats')
        .updateData({info: (infoCount + 1)});
  }

  Future decrementUserInfo(String info) async {
    _user = await _auth.currentUser();
    int infoCount = await getUserInfo(info);
    await _firestore
        .collection('User')
        .document(_user.uid)
        .collection('Info')
        .document('profile_stats')
        .updateData({info: (infoCount - 1)});
  }

  Future addBookToWishlist(String isbn) async {
    _user = await _auth.currentUser();
    await _firestore
        .collection('User')
        .document(_user.uid)
        .collection('Wishlist')
        .add({'isbn': isbn});
  }

  Future getWishlist() async {
    List<String> wishlistISBN = [];
    _user = await _auth.currentUser();
    QuerySnapshot snapshot = await _firestore
        .collection('User')
        .document(_user.uid)
        .collection('Wishlist')
        .getDocuments();

    for (DocumentSnapshot ds in snapshot.documents) {
      wishlistISBN.add(ds.data['isbn']);
    }
    return wishlistISBN;
  }
}
