import 'package:flutter/material.dart';
import 'book.dart';

class Shelf extends StatelessWidget {
  final String shelfName;
  List<Book> bookList = [Book(title: 'Hello'), Book(title: 'Get')];

  Shelf({this.shelfName});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: EdgeInsets.only(
                left: 35.0,
                top: 10.0,
                right: 25.0,
                bottom: 10.0,
              ),
              child: Text(
                shelfName,
                style: TextStyle(
                  color: const Color(0xff30332E),
                  fontFamily: 'RobotoSlab',
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
          Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 20.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment
                        .bottomCenter, // 10% of the width, so there are ten blinds.
                    colors: [
                      const Color(0xFFFFEDE1),
                      const Color(0xff6F370F)
                    ], // whitish to gray
                    tileMode: TileMode.repeated,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 8.0),
                height: 160.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: bookList,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
