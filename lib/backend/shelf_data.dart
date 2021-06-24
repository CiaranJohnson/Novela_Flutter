import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:novela/components/shelf.dart';
import '../components/book.dart';

class ShelfData {
  final Firestore firestore;

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
      return [];
    }
  }

  Future<List<Book>> getShelvesBooks(String genre) async {
    List<Book> bookList = [];
    try {
      QuerySnapshot querySnapshot = await Firestore.instance
          .collection('Library')
          .document('genre')
          .collection(genre)
          .getDocuments();
      for (DocumentSnapshot ds in querySnapshot.documents) {
        bookList.add(Book(
            isbn: ds.documentID,
            title: ds.data['title'],
            author: ds.data['Author'],
            coverPic: ds.data['cover_pic']));
      }
      return bookList;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<Book>> getBooks(List<String> booksISBN) async {
    List<Book> bookList = [];
    try {
      QuerySnapshot querySnapshot =
          await Firestore.instance.collection('Library').getDocuments();
      for (DocumentSnapshot ds in querySnapshot.documents) {
        if (booksISBN.contains(ds.documentID)) {
          bookList.add(
            Book(
              title: ds.data['title'],
              author: ds.data['author'],
              coverPic: ds.data['cover_pic'],
              isbn: ds.documentID,
            ),
          );
        }
      }
    } catch (e) {
      print(e);
    }
    return bookList;
  }

  Future<Shelf> getShelf(String shelfName, List<String> booksISBN) async {
    Shelf shelf;
    List<Book> bookList = await getBooks(booksISBN);
    shelf = Shelf(
      shelfName: shelfName,
      bookList: bookList,
    );
    return shelf;
  }

  Future<Map<String, List<String>>> findMyShelves() async {
    Map<String, List<String>> shelfISBNs = {};
    try {
      DocumentSnapshot snapshot = await Firestore.instance
          .collection('Shelves')
          .document('global')
          .get();
      for (String key in snapshot.data.keys) {
        List<String> bookISBN = [];
        QuerySnapshot querySnapshot = await Firestore.instance
            .collection("Shelves")
            .document('global')
            .collection(snapshot.data[key])
            .getDocuments();
        for (DocumentSnapshot ds in querySnapshot.documents) {
          bookISBN.add(ds.documentID);
        }
        shelfISBNs[snapshot.data[key]] = bookISBN;
      }
    } catch (e) {
      print(e);
    }
    return shelfISBNs;
  }

  Future<List<Shelf>> getShelvesData() async {
    Map<String, List<String>> generalShelves = await findMyShelves();
    List<Shelf> shelfList = [];
    Map<String, List<Book>> books = {};
    for (String shelfName in generalShelves.keys) {
      Shelf shelf = await getShelf(shelfName, generalShelves[shelfName]);
      shelfList.add(shelf);
    }
    return shelfList;
  }

//  Future<List<Shelf>> getShelvesData() async {
//    List<String> genreList = await shelvesName();
//    List<Shelf> shelfList = [];
//    Map<String, List<Book>> books = {};
//    for (String genre in genreList) {
//      books[genre] = await getShelvesBooks(genre);
//      shelfList.add(Shelf(
//        shelfName: genre,
//        bookList: books[genre],
//      ));
//    }
//    return shelfList;
//  }
}
