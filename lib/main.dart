import 'package:flutter/material.dart';
import 'package:personal_care/screen/signin_screen.dart';

void main() {
  runApp(PersonalCareApp());
}

class PersonalCareApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: SignInScreen.routeName,
      routes: {
        SignInScreen.routeName: (context) => SignInScreen(),
      },
    );
  }
}
