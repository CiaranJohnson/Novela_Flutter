import 'package:flutter/material.dart';
import 'package:novela/components/book.dart';

class BookInfoScreen extends StatelessWidget {
  final String title;
  final String coverPic;
  BookInfoScreen({this.title, this.coverPic});
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
              Text(
                title,
                style: TextStyle(
                  fontSize: 10.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Book(
                title: title,
                coverPic: coverPic,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
