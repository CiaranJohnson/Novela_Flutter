import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class FirebaseStorageManager {
  final FirebaseStorage storage =
      FirebaseStorage(storageBucket: 'gs://novela-bbd01.appspot.com/');

  Future<String> downloadImages() async {
    print('Start');
    final StorageReference storageReference = storage
        .ref()
        .child('Library')
        .child('BookCover')
        .child('Cherub')
        .child('brigands_mc.jpeg');
    print('End');
    try {
      final String downloadURL = await storageReference.getDownloadURL();
      if (downloadURL != null) {
        print('Image not null');
        return downloadURL;
      } else {
        print('null');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<String> uploadFile(File _image, FirebaseUser user) async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('user/${user.uid}/profile_pic.jpg');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    print('File Uploaded');
    String profilePicURL = await storageReference.getDownloadURL();
    return profilePicURL;
  }
}
