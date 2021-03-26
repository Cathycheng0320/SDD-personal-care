import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:personal_care/model/personalcare.dart';

import 'question_screen.dart';

class QuestionHomeScreen extends StatefulWidget {
  static const routeName = '/homeScreen/questionHomeScreen';

  @override
  State<StatefulWidget> createState() {
    return _QuestionHomeState();
  }
}

class _QuestionHomeState extends State<QuestionHomeScreen> {
  _Controller con;
  File image;
  var formKey = GlobalKey<FormState>();
  FirebaseUser user;
  List<PersonalCare> personalCare;

  @override
  void initState() {
    super.initState();
    con = _Controller(this);
  }

  void render(fn) => setState(fn);

  @override
  Widget build(BuildContext context) {
    Map args = ModalRoute.of(context).settings.arguments;
    user ??= args['user'];
    personalCare ??= args['personalCareList'];
    return Scaffold(
      appBar: AppBar(
        title: Text('Question Form'),
      ),
      body: Text('Question Home'),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_comment),
        onPressed: con.add_comment,
      ),
    );
  }
}

class _Controller {
  _QuestionHomeState _state;
  _Controller(this._state);

  void add_comment() async {
    await Navigator.pushNamed(_state.context, QuestionFormScreen.routeName,
        arguments: {
          'user': _state.user,
          'personalCareList': _state.personalCare
        });
    _state.render(() {});
  }
}
