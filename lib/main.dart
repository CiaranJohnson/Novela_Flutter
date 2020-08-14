import 'package:flutter/material.dart';
import 'package:novela/screens/browse_screen.dart';
import 'package:novela/screens/log_in_screen.dart';
import 'package:novela/screens/profile_screen.dart';
import 'package:novela/screens/registration_screen.dart';
import 'package:novela/screens/sign_up_screen.dart';
import 'package:novela/screens/splash_screen.dart';
import 'package:novela/screens/user_info_screen.dart';
import 'package:novela/screens/wishlist_screen.dart';

void main() {
  runApp(NovelaStructure());
}

class NovelaStructure extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: RegistrationScreen.id,
      routes: {
        BrowseScreen.id: (context) => BrowseScreen(),
        LogInScreen.id: (context) => LogInScreen(),
        SignUpScreen.id: (context) => SignUpScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        SplashScreen.id: (context) => SplashScreen(),
        ProfileScreen.id: (context) => ProfileScreen(),
        UserInfoScreen.id: (context) => UserInfoScreen(),
        WishlistScreen.id: (context) => WishlistScreen(),
      },
    );
  }
}
