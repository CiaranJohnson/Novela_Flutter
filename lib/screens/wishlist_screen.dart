import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:novela/components/book.dart';
import 'package:novela/components/bookshop_app_bar.dart';
import 'package:novela/widgets/profile_picture.dart';

import '../constants.dart';

class WishlistScreen extends StatefulWidget {
  static const String id = 'wishlist_screen';
  final String name;
  final List<Book> books;
  final ImageProvider profilePic;
  WishlistScreen({this.name, this.books, this.profilePic});

  @override
  _WishlistScreenState createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  String getFirstName(
    String fullName,
  ) {
    return fullName.split(" ")[0];
  }

  List<Row> getRows(List<Book> books) {
    List<Row> bookRows = [];
    if (books != null) {
      int removeBooksNumber = books.length % 3;
      for (int i = 0; i < (books.length - removeBooksNumber); i += 3) {
        print(i);
        bookRows.add(
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              books[i],
              books[i + 1],
              books[i + 2],
            ],
          ),
        );
      }
      if (removeBooksNumber != 0) {
        print('Add empty containers');
        bookRows.add(addContainers(
            books.sublist(books.length - removeBooksNumber, books.length)));
      }
    }
    return bookRows;
  }

  Row addContainers(List<Widget> books) {
    List<Widget> listOfItems = [];
    int remaindingBooks = 0;
    if (books == null || books.length == 0) {
      remaindingBooks = 3;
    } else {
      remaindingBooks = books.length % 3;
    }

    for (int i = 0; i < 3; i++) {
      if (i < remaindingBooks) {
        listOfItems.add(books[i]);
      } else {
        listOfItems.add(Container(
          height: 150.0,
          width: 120.0,
          color: kNovelaWhite,
        ));
      }
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: listOfItems,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 50.0),
            height: 180.0,
            width: double.infinity,
            decoration: BoxDecoration(
              color: kNovelaGreen,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    left: 10.0,
                    right: 5.0,
                  ),
                  child: ProfilePicture(
                    diameterContainer: 90.0,
                    image: widget.profilePic,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 15.0,
                      ),
                      child: Text(
                        'novela',
                        style: TextStyle(
                          fontSize: 30.0,
                          color: kNovelaWhite,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'RobotoSlab',
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 10.0),
                      child: AutoSizeText(
                        '${getFirstName(widget.name)}\'s Wishlist',
                        style: TextStyle(
                          color: kNovelaWhite,
                          fontFamily: 'RobotoSlab',
                          fontSize: 31.0,
                        ),
                        minFontSize: 12.0,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              child: ListView(
                children: getRows(widget.books),
              ),
//              child: ListView(
//                children: books,
//              ),
            ),
          )
        ],
      ),
    );
  }
}

//class BookRow extends StatelessWidget {
//  List<Book> books;
//  BookRow(books) {
//    if (books == null || books.length == 0) {
//      books = addContainers(books);
//    }
//  }
//  @override
//  Widget build(BuildContext context) {
//    return Row(
//      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//      children: books,
//    );
//  }
//}
