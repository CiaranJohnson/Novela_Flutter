import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:novela/backend/current_user_data.dart';
import 'package:novela/components/book.dart';
import 'package:novela/components/bookshop_app_bar.dart';
import 'package:novela/constants.dart';
import 'package:novela/screens/registration_screen.dart';
import '../components/shelf.dart';
import '../backend/shelf_data.dart';

final _firestore = Firestore.instance;
FirebaseUser loggedInUser;

class BrowseScreen extends StatefulWidget {
  static const String id = 'browse_screen';

  final List<Shelf> shelves;
  BrowseScreen({@required this.shelves});

  @override
  _BrowseScreenState createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  final _auth = FirebaseAuth.instance;
  FirebaseUser user;
  String _name;
  String imageURL;
  bool gotImage = false;

  @override
  void initState() {
    // TODO: implement initState
    getCurrentUser();
    super.initState();
  }

  void getCurrentUser() async {
    try {
      user = await _auth.currentUser();
      if (user != null) {
        setState(() {
          _name = user.displayName;
        });
      }
    } catch (e) {
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
            BookshopAppBar(
              name: _name,
            ),
            Expanded(
              child: Container(
                child: ListView(
                  children: widget.shelves != null ? widget.shelves : [],
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
