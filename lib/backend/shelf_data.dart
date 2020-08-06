import 'package:cloud_firestore/cloud_firestore.dart';
import '../components/book.dart';

class ShelfData {
  final Firestore firestore;

//  List<String> genreList = [];
//  Map<String, List<String>> books = {};

  ShelfData({this.firestore});

  Future<List<String>> shelvesName() async {
    List<String> genreList = [];
    try {
      await firestore
          .collection('Library')
          .document('genre')
          .get()
          .then((DocumentSnapshot ds) {
        for (String genre in ds.data.values) {
          genreList.add(genre);
        }
      });
      return genreList;
    } catch (e) {
      print(e);
    }
  }

//  List<String> get getShelvesNames => genreList;

  Future<List<Book>> getShelvesBooks(String genre) async {
    List<Book> bookList = [];
    print('Getting $genre\'s books');
    try {
      QuerySnapshot querySnapshot = await Firestore.instance
          .collection('Library')
          .document('genre')
          .collection(genre)
          .getDocuments();
      for (DocumentSnapshot ds in querySnapshot.documents) {
        for (String books in ds.data.values) {
          String imageURL = 'Library/BookCover/$genre/$books';
          bookList.add(Book(
            title: books,
          ));
        }
      }
      return bookList;
    } catch (e) {
      print(e);
    }
  }
}
