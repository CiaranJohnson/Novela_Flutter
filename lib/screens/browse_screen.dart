import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:novela/components/bookshop_app_bar.dart';
import 'package:novela/constants.dart';
import 'package:novela/screens/registration_screen.dart';
import '../components/shelf.dart';

class BrowseScreen extends StatefulWidget {
  static const String id = 'browse_screen';

  @override
  _BrowseScreenState createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  final List<Shelf> shelves = [
    Shelf(shelfName: 'Action'),
    Shelf(shelfName: 'Mystery'),
    Shelf(shelfName: 'Food and Lifestyle')
  ];

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseUser user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void getCurrentUser() async {
    user = await auth.currentUser();
    if (user == null) {
      Navigator.pushNamed(context, RegistrationScreen.id);
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
