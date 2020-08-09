import 'package:flutter/material.dart';
import 'package:novela/screens/book_info_screen.dart';

class Book extends StatelessWidget {
  final String title;
  final String coverPic;

  Book({@required this.title, @required this.coverPic});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => BookInfoScreen(
              title: title,
              coverPic: coverPic,
            ),
          ),
        );
      },
      child: Container(
        height: 100.0,
        width: 100.0,
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
