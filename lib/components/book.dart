import 'package:flutter/material.dart';
import 'package:novela/screens/book_info_screen.dart';

class Book extends StatelessWidget {
  final String isbn;
  final String title;
  final String author;
  final String coverPic;
  final double height;
  final double width;

  Book(
      {@required this.isbn,
      @required this.title,
      @required this.coverPic,
      this.author,
      this.height = 150.0,
      this.width = 100.0});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => BookInfoScreen(
              isbn: isbn,
              title: title,
              author: author,
              coverPic: coverPic,
            ),
          ),
        );
      },
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.teal,
          borderRadius: BorderRadius.circular(10.0),
          image: DecorationImage(
              image: NetworkImage(this.coverPic), fit: BoxFit.cover),
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 5.0,
        ),
      ),
    );
  }
}
