import 'package:flutter/material.dart';
import 'package:novela/components/bookshop_app_bar.dart';
import 'package:novela/constants.dart';
import '../components/shelf.dart';

class BrowseScreen extends StatelessWidget {
  static const String id = 'browse_screen';

  final List<Shelf> shelves = [
    Shelf(shelfName: 'Action'),
    Shelf(shelfName: 'Mystery'),
    Shelf(shelfName: 'Food and Lifestyle')
  ];

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
                  children: shelves,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
