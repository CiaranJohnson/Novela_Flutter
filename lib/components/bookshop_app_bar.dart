import 'package:flutter/material.dart';
import 'package:novela/components/current_user.dart';
import 'package:novela/constants.dart';
import 'package:novela/screens/profile_screen.dart';
import 'package:novela/widgets/profile_picture.dart';
import 'package:auto_size_text/auto_size_text.dart';

class BookshopAppBar extends StatelessWidget {
  final String name;
  final ImageProvider profilePic;

  String getFirstName(String fullName) {
    return fullName.split(" ")[0];
  }

  BookshopAppBar({@required this.name, this.profilePic});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("On tap appbar pic: $profilePic");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfileScreen(
              profilePicProvider: profilePic,
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.only(top: 50.0),
        height: 180.0,
        width: double.infinity,
        decoration: BoxDecoration(
          color: kNovelaGreen,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                left: 10.0,
                right: 5.0,
              ),
              child: ProfilePicture(
                diameterContainer: 90.0,
                image: profilePic,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 15.0,
                  ),
                  child: Text(
                    'novela',
                    style: TextStyle(
                      fontSize: 30.0,
                      color: kNovelaWhite,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'RobotoSlab',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width - 120,
                    child: AutoSizeText(
                      '${getFirstName(name)}\'s Bookshop',
                      style: TextStyle(
                        color: kNovelaWhite,
                        fontFamily: 'RobotoSlab',
                        fontSize: 31.0,
                      ),
                      maxLines: 1,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
