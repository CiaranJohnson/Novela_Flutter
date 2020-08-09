import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class FirebaseStorageManager {
  final FirebaseStorage storage =
      FirebaseStorage(storageBucket: 'gs://novela-bbd01.appspot.com/');

  Future<String> uploadProfilePicFile(File _image, FirebaseUser user) async {
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
