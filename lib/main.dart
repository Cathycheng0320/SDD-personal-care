import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:personal_care/controller/event_firestore_service.dart';
import 'package:personal_care/screen/aboutpage_screen.dart';
import 'package:personal_care/screen/addeventpage_screen.dart';
import 'package:personal_care/screen/event_details.dart';
import 'package:personal_care/screen/home_screen.dart';
import 'package:personal_care/screen/question_screen.dart';
import 'package:personal_care/screen/questionhome_screen.dart';
import 'package:personal_care/screen/reset_password_screen.dart';
import 'package:personal_care/screen/signin_screen.dart';
import 'package:personal_care/screen/signup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(PersonalCareApp());
}

class PersonalCareApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       
      initialRoute: SignInScreen.routeName,
      routes: {
        SignInScreen.routeName: (context) => SignInScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
        SignUpScreen.routeName: (context) => SignUpScreen(),
        AddEventPageScreen.routeName: (context) => AddEventPageScreen(),
        AboutPageScreen.routeName: (context) => AboutPageScreen(),
        QuestionFormScreen.routeName: (context) => QuestionFormScreen(),
        QuestionHomeScreen.routeName: (context) => QuestionHomeScreen(),
        ResetPasswordScreen.routeName: (context) => ResetPasswordScreen(),
        // EventDetails.routeName: (context) => EventDetails(),
      },
    );
  }
}
