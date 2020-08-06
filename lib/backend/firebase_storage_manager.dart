import 'package:firebase_storage/firebase_storage.dart';

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
}
