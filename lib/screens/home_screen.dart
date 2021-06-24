import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:novela/components/bookshop_app_bar.dart';
import 'package:novela/components/shelf.dart';
import 'package:novela/screens/book_info_screen.dart';
import 'package:novela/screens/browse_screen.dart';
import 'package:novela/screens/profile_screen.dart';
import 'package:novela/screens/registration_screen.dart';
import 'package:novela/widgets/novela_leaf_logo.dart';

import '../constants.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';

  final List<Shelf> shelves;
  final String profilePicURL;
  HomeScreen({@required this.shelves, this.profilePicURL});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = FirebaseAuth.instance;
  FirebaseUser user;
  String _name;
  String imageURL;
  bool gotImage = false;

  @override
  void initState() {
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

  void _onItemTapped(int index) {
    switch (index) {
      case (0):
        Navigator.pushNamed(context, HomeScreen.id);
        break;
      case (1):
        Navigator.pushNamed(context, BrowseScreen.id);
        break;
      case (2):
        Navigator.pushNamed(context, ProfileScreen.id);
        break;
      case (3):
        Navigator.pushNamed(context, SettingScreen.id);
        break;
      default:
        print('[ERROR]: Index $index is not an option, error in code.');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kNovelaWhite,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(150.0),
        child: AppBar(
          flexibleSpace: BookshopAppBar(
            name: _name,
            profilePic: widget.profilePicURL != null
                ? NetworkImage(widget.profilePicURL)
                : AssetImage('images/leaf.png'),
          ),
          backgroundColor: kNovelaGreen,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.notifications,
                color: kNovelaWhite,
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.search,
                color: kNovelaWhite,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
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
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: kNovelaGreen,
            ),
            title: Text(
              'Home',
              style: TextStyle(
                color: kNovelaBlue,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.library_books,
              color: kNovelaGreen,
            ),
            title: Text(
              'Book',
              style: TextStyle(
                color: kNovelaBlue,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: kNovelaGreen,
            ),
            title: Text('Profile'),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.view_headline,
              color: kNovelaGreen,
            ),
            title: Text('Settings'),
          ),
        ],
        onTap: _onItemTapped,
      ),
    );
  }
}
