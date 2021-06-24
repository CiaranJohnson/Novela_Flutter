import 'package:flutter/material.dart';
import 'package:novela/backend/current_user_data.dart';
import 'package:novela/backend/shelf_data.dart';
import 'package:novela/components/book.dart';
import 'package:novela/constants.dart';
import 'package:novela/screens/friend_screen.dart';
import 'package:novela/screens/registration_screen.dart';
import 'package:novela/screens/wishlist_screen.dart';
import 'package:novela/widgets/profile_info_card.dart';
import 'package:novela/widgets/profile_picture.dart';
import 'package:bordered_text/bordered_text.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatefulWidget {
  static const String id = 'profile_screen';

  ImageProvider profilePicProvider;
  ProfileScreen({this.profilePicProvider});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseUser _user;
  CurrentUserData _currentUserData;

  String _name;
  int _friends;
  int _books;
  int _wishlist;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      _user = await _auth.currentUser();
      if (_user != null) {
        _currentUserData = CurrentUserData();
        int friends = await _currentUserData.getPersonalInfo("Friends");
        int wishlist = await _currentUserData.getPersonalInfo("Wishlist");
        int books = await _currentUserData.getPersonalInfo("Books");
        setState(() {
          _name = _user.displayName;
          _friends = friends;
          _wishlist = wishlist;
          _books = books;
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
            Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height / 2 + 100,
                  color: kNovelaWhite,
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 2,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment
                          .bottomCenter, // 10% of the width, so there are ten blinds.
                      colors: [
                        kNovelaBlue,
                        kNovelaGreen,
                      ], // whitish to gray
                      tileMode: TileMode.repeated,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              flex: 10,
                              child: Padding(
                                padding: EdgeInsets.only(left: 60.0),
                                child: BorderedText(
                                  strokeWidth: 1.0,
                                  strokeColor: kTextBorder,
                                  child: Text(
                                    'novela',
                                    style: TextStyle(
                                      color: kNovelaWhite,
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'RobotoSlab',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                right: 20.0,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  print('Edit Profile');
                                },
                                child: CircleAvatar(
                                  backgroundColor: kNovelaGreen,
                                  child: Icon(
                                    Icons.edit,
                                    color: kNovelaWhite,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 20,
                        ),
                        ProfilePicture(
                          diameterContainer:
                              MediaQuery.of(context).size.width / 3,
                          innerBorder: true,
                          image: widget.profilePicProvider != null
                              ? widget.profilePicProvider
                              : AssetImage('images/leaf.png'),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          _name == null ? '' : _name,
                          style: TextStyle(
                              color: kNovelaWhite,
                              fontSize: 30.0,
                              fontFamily: 'RobotoSlab',
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0.0,
                  child: Container(
                    height: 150.0,
                    width: 300.0,
                    child: Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      FriendScreen(
                                    profilePic: widget.profilePicProvider,
                                  ),
                                ));
                          },
                          child: ProfileInfoCard(
                            cardTitle: 'Friends',
                            cardValue:
                                _friends == null ? "-" : _friends.toString(),
                          ),
                        ),
                        ProfileInfoCard(
                          cardTitle: 'Books',
                          cardValue: _books == null ? "-" : _books.toString(),
                        ),
                        GestureDetector(
                          onTap: () async {
                            List<String> wishlistISBN =
                                await _currentUserData.getWishlist();
                            List<Book> wishlistBooks =
                                await ShelfData().getBooks(wishlistISBN);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    WishlistScreen(
                                  name: _name,
                                  books: wishlistBooks,
                                  profilePic: widget.profilePicProvider,
                                ),
                              ),
                            );
                          },
                          child: ProfileInfoCard(
                            cardTitle: 'Wishlist',
                            cardValue:
                                _wishlist == null ? "-" : _wishlist.toString(),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Expanded(
              child: Container(
                child: Scrollbar(
                  child: ListView(
                    padding: EdgeInsets.all(20.0),
                    children: <Widget>[
                      GestureDetector(
                        // pressing this should make an animation which
                        // enlarges the bio box to take up the majority
                        // of the screen so info can be added
                        onTap: () {
                          print('Edit Bio');
                        },
                        child: Container(
                          child: BioBox(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 60.0, vertical: 20.0),
                        child: RaisedButton(
                          child: Center(
                            child: Text(
                              'Edit Profile',
                              style: TextStyle(
                                  color: kNovelaWhite,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          color: kNovelaGreen,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          onPressed: () {},
                        ),
                      ),
                      SignOutButton(
                        auth: _auth,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SignOutButton extends StatelessWidget {
  FirebaseAuth auth;
  SignOutButton({this.auth});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60.0, vertical: 20.0),
      child: RaisedButton(
        child: Center(
          child: Text(
            'Sign Out',
            style: TextStyle(
                color: kNovelaWhite,
                fontSize: 20.0,
                fontWeight: FontWeight.bold),
          ),
        ),
        color: kNovelaBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        onPressed: () async {
          await auth.signOut();
          Navigator.pushNamed(context, RegistrationScreen.id);
        },
      ),
    );
  }
}

class BioBox extends StatelessWidget {
  ImageProvider lastReadCover;
  String bioText;
  String lastReadTitle;

  BioBox({this.bioText, this.lastReadCover, this.lastReadTitle});
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          height: 200.0,
          width: MediaQuery.of(context).size.width,
        ),
        Positioned(
          left: 40.0,
          child: Container(
            padding: EdgeInsets.only(left: 70.0, top: 30.0),
            height: 200.0,
            width: MediaQuery.of(context).size.width * 5 / 7,
            decoration: BoxDecoration(
              color: kNovelaBlue,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Bio:',
                  style: TextStyle(
                    color: kNovelaWhite,
                    fontFamily: 'RobotoSlab',
                    fontSize: 16.0,
                  ),
                ),
                Text(
                  bioText == null ? '- Click to add info -' : bioText,
                  style: TextStyle(
                    color: kNovelaWhite,
                    fontFamily: 'RobotoSlab',
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  'Last Read:',
                  style: TextStyle(
                    color: kNovelaWhite,
                    fontFamily: 'RobotoSlab',
                    fontSize: 14.0,
                  ),
                ),
                Text(
                  lastReadTitle == null ? 'Add Book Title' : lastReadTitle,
                  style: TextStyle(
                    color: kNovelaWhite,
                    fontFamily: 'RobotoSlab',
                    fontSize: 15.0,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 0.0,
          child: Container(
            height: 150.0,
            width: 100.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: kNovelaGreen,
            ),
            child: lastReadCover == null
                ? Icon(
                    Icons.add_box,
                    size: 40.0,
                  )
                : Image(
                    image: AssetImage('images/book_cover.png'),
                  ),
          ),
        ),
      ],
    );
  }
}

// REFACTOR THIS PAGE ASAP
