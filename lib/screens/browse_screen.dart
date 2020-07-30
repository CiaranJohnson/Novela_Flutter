import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:novela/components/bookshop_app_bar.dart';
import 'package:novela/constants.dart';
import '../components/shelf.dart';
import '../backend/shelf_data.dart';

final _firestore = Firestore.instance;
FirebaseUser loggedInUser;

class BrowseScreen extends StatefulWidget {
  static const String id = 'browse_screen';

  final FirebaseStorage storage =
      FirebaseStorage(storageBucket: 'gs://novela-bbd01.appspot.com/');

  @override
  _BrowseScreenState createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  final _auth = FirebaseAuth.instance;

  List<Shelf> shelves = [];
  List<Container> coverPics = [];

  String imageURL;
  bool gotImage = false;

  @override
  void initState() {
    // TODO: implement initState
    getCurrentUser();
//    getShelveData();
    downloadImages();
    super.initState();
  }

  void getShelveData() async {
    ShelfData shelfData = ShelfData(firestore: _firestore);
    List<String> genreList = await shelfData.shelvesName();
    print(genreList);

    for (String genre in genreList) {
      List<String> bookList = await shelfData.getShelvesBooks(genre);
      for (String book in bookList) {
        if (book == 'Library/BookCover/HarryPotter/chamber_of_secrets.jpg') {
          setState(() {
            imageURL = book;
            gotImage = true;
          });
        }
      }
    }
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  void downloadImages() async {
    print('Start');
    final StorageReference storageReference = widget.storage
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
        setState(() {
          imageURL = downloadURL;
          gotImage = true;
        });
      } else {
        print('null');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kNovelaWhite,
      body: Container(
        child: Column(
          children: <Widget>[
            BookshopAppBar(),
            Expanded(
              child: Container(
                child: ListView(
                  children: <Widget>[
                    Container(
                      child: gotImage
                          ? Image(image: NetworkImage(imageURL))
                          : Block(),
                    ),
                  ],
//                  children: shelves,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Block extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kNovelaBlue,
      height: 100.0,
      width: 100.0,
    );
  }
}
