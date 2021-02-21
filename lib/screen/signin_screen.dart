import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:personal_care/controller/firebasecontrollor.dart';

class SignInScreen extends StatefulWidget {
  static const routeName = '/signInScreen';
  @override
  State<StatefulWidget> createState() {
    return _SignInState();
  }
}

class _SignInState extends State<SignInScreen> {
  _Controller con;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    con = _Controller(this);
  }

  void render(fn) => setState(fn);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Sign In'),
        ),
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Email',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  validator: con.validatorEmail,
                  onSaved: con.saveEmail,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Password',
                  ),
                  obscureText: true,
                  autocorrect: false,
                  validator: con.validatorPassword,
                  onSaved: con.savedPassword,
                ),
                RaisedButton(
                  onPressed: con.signIn,
                  child: Text(
                    'Sign In',
                    style: Theme.of(context).textTheme.button,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class _Controller {
  _SignInState state;
  _Controller(this.state);
  String email;
  String password;

  String validatorEmail(String value) {
    if (value.contains('@') && value.contains('.'))
      return null;
    else
      return 'Invalid email address';
  }

  void saveEmail(String value) {
    email = value;
  }

  String validatorPassword(String value) {
    if (value.length < 6) {
      return 'password min 6 chars';
    } else {
      return null;
    }
  }

  void savedPassword(String value) {
    password = value;
  }

  void signIn() async {
    if (!state.formKey.currentState.validate()) return;

    state.formKey.currentState.save();

    User user;
    try {
      user = await FirebaseController.signIn(email: email, password: password);
      print('=======${user.email}');
    } catch (e) {
      print('====== $e');
    }
  }
}
