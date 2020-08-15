import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FriendsBackend {
  Firestore _firestore = Firestore.instance;

  Future findAllUsersProfilePics() async {
    List<String> profilePics = [];
    print('Getting Friends');

    Query query = await _firestore
        .collection('User')
        .where('username', isEqualTo: 'Led Zeplin');

    QuerySnapshot snapshot = await query.getDocuments();
    print("Number of friends is ${snapshot.documents.length}");
    for (DocumentSnapshot ds in snapshot.documents) {
      DocumentSnapshot snap = await _firestore
          .collection('User')
          .document(ds.documentID)
          .collection('Info')
          .document('profile_pic')
          .get();

      profilePics.add(snap.data['profile_pic']);
    }
    return profilePics;
  }
}
