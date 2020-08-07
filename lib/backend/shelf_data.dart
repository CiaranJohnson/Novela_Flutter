import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:novela/components/shelf.dart';
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
    try {
      QuerySnapshot querySnapshot = await Firestore.instance
          .collection('Library')
          .document('genre')
          .collection(genre)
          .getDocuments();
      for (DocumentSnapshot ds in querySnapshot.documents) {
        bookList.add(
            Book(title: ds.data['title'], cover_pic: ds.data['cover_pic']));
      }
      return bookList;
    } catch (e) {
      print(e);
    }
  }

  Future<List<Shelf>> getShelvesData() async {
    List<String> genreList = await shelvesName();
    List<Shelf> shelfList = [];
    Map<String, List<Book>> books = {};
    for (String genre in genreList) {
      books[genre] = await getShelvesBooks(genre);
      shelfList.add(Shelf(
        shelfName: genre,
        bookList: books[genre],
      ));
    }
    return shelfList;
  }
}
