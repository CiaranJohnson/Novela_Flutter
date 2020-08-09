import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:novela/backend/firebase_storage_manager.dart';

class InitialiseNewUser {
  final _firestore = Firestore.instance;
  final _auth = FirebaseAuth.instance;
  FirebaseUser _user;

  Future createNewUser(String firstName, String lastName, File profilePicFile,
      FirebaseStorageManager firebaseStorageManager) async {
    // Add new user info stats to database
    _user = await _auth.currentUser();
    UserUpdateInfo userInfo = UserUpdateInfo();
    userInfo.displayName = "$firstName $lastName";
    await _user.updateProfile(userInfo);
    await _user.reload();
    await _initNewUser();

    // Add Profile Picture to File Storage and download URL to database
    if (profilePicFile != null) {
      String _profilePicURL = await firebaseStorageManager.uploadProfilePicFile(
          profilePicFile, _user);
      print(_profilePicURL);
      if (_profilePicURL != null) {
        _addProfilePicture(_profilePicURL);
      } else {
        print('URl is null');
      }
    }
  }

  // Initialise User Stats in Database
  Future _initNewUser() async {
    Map<String, int> userInfo = {'Friends': 0, 'Books': 0, 'Wishlist': 0};
    _firestore
        .collection('User')
        .document(_user.uid)
        .collection('Info')
        .document('profile_stats')
        .setData(userInfo);
  }

  // Add Profile Picture URL to database
  Future _addProfilePicture(String profilePicURL) async {
    Map<String, String> userInfo = {'profile_pic': profilePicURL};
    _firestore
        .collection('User')
        .document(_user.uid)
        .collection('Info')
        .document('profile_pic')
        .setData(userInfo);
  }
}
