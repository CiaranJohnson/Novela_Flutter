import 'package:flutter/material.dart';

class Book extends StatelessWidget {
  final String title;
  Book({@required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      width: 100.0,
      decoration: BoxDecoration(
        color: Colors.teal,
        borderRadius: BorderRadius.circular(10.0),
        image:
            DecorationImage(image: NetworkImage(this.title), fit: BoxFit.cover),
      ),
      margin: EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 5.0,
      ),
    );
  }
}
