import 'package:flutter/material.dart';
import 'package:novela/components/current_user.dart';
import 'package:novela/constants.dart';
import 'package:novela/screens/profile_screen.dart';
import 'package:novela/widgets/profile_picture.dart';

class BookshopAppBar extends StatelessWidget {
  CurrentUser currentUser = CurrentUser(name: 'Ciaran');
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ProfileScreen.id);
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
          children: <Widget>[
            ProfilePicture(
              diameterContainer: 90.0,
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
                Text(
                  '${currentUser.name}\'s Bookshop',
                  style: TextStyle(
                    color: kNovelaWhite,
                    fontFamily: 'RobotoSlab',
                    fontSize: 34.0,
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
