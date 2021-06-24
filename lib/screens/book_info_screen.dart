import 'package:flutter/material.dart';
import 'package:novela/backend/current_user_data.dart';
import 'package:novela/components/book.dart';
import 'package:novela/constants.dart';

class BookInfoScreen extends StatelessWidget {
  final String title;
  final String coverPic;
  final String author;
  final String isbn;
  BookInfoScreen({this.isbn, this.title, this.author, this.coverPic});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 10.0),
                        color: kNovelaWhite,
                        height: 150.0,
                        width: 140.0,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20.0, bottom: 10.0),
                        child: Book(
                          isbn: isbn,
                          title: title,
                          coverPic: coverPic,
                          height: 150.0,
                          width: 100.0,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(right: 30.0),
                      padding: EdgeInsets.all(20.0),
                      height: 180.0,
                      width: MediaQuery.of(context).size.width - 180,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20.0),
                            topLeft: Radius.circular(20.0)),
                        color: kNovelaBlue,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              "Title: $title",
                              overflow: TextOverflow.clip,
                              softWrap: true,
                              maxLines: 3,
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: kNovelaWhite,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "Author: $author",
                              overflow: TextOverflow.clip,
                              softWrap: true,
                              maxLines: 3,
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: kNovelaWhite,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30.0),
                height: 300.0,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0)),
                  color: kNovelaBlue,
                ),
              ),
              RaisedButton(
                onPressed: () {
                  CurrentUserData userData = CurrentUserData();
                  userData.incrementUserInfo('Wishlist');
                  userData.addBookToWishlist(isbn);
                },
                color: kNovelaGreen,
                elevation: 5.0,
                child: Text(
                  'Add to Wishlist',
                  style: TextStyle(color: kNovelaWhite),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
