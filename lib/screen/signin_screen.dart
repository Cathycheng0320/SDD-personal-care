import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:personal_care/controller/Authentication.dart';
import 'package:personal_care/controller/firebasecontrollor.dart';
import 'package:personal_care/screen/home_screen.dart';
import 'package:personal_care/screen/myview/mydialog.dart';
import 'package:personal_care/screen/reset_password_screen.dart';
import 'package:personal_care/screen/signup_screen.dart';

class SignInScreen extends StatefulWidget {
  static const routeName = '/signInScreen';
  @override
  State<StatefulWidget> createState() {
    return _SignInState();
  }
}

class _SignInState extends State<SignInScreen> {
  _Controller con;
  var formKey = GlobalKey<FormState>();
  FirebaseUser user;
  @override
  void initState() {
    super.initState();
    con = _Controller(this);
  }

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
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Image.asset('assets/images/1.jpg'),
                  Positioned(
                    top: 130.0,
                    left: 12.0,
                    child: Text(
                      'personal care',
                      style: TextStyle(
                          color: Colors.blue[900],
                          fontSize: 25.0,
                          fontFamily: 'AudioWide'),
                    ),
                  ),
                ],
              ),
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
              Container(
                width: 350.0,
                height: 60.0,
                padding: const EdgeInsets.only(top: 16.0),
                // ignore: deprecated_member_use
                child: RaisedButton(
                  child: Text(
                    'Sign In',
                    style: TextStyle(fontSize: 20.0, color: Colors.white),
                  ),
                  color: Colors.blue,
                  onPressed: con.signIn,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                ),
              ),
              Container(
                width: 350.0,
                height: 60.0,
                padding: const EdgeInsets.only(top: 16.0),
                // ignore: deprecated_member_use
                child: RaisedButton(
                  child: Text(
                    'Sign In With Google',
                    style: TextStyle(fontSize: 20.0, color: Colors.white),
                  ),
                  color: Colors.blue,
                  onPressed: () {
                    signInWithGoogle().then((user) async {
                      this.user = user;
                      print('========google sign in start');
                      var personalCare =
                          await FirebaseController.getPersonalCare(user.email);
                      print('========google call');
                      Navigator.pushReplacementNamed(
                          context, HomeScreen.routeName, arguments: {
                        'user': user,
                        'personalCareList': personalCare
                      });
                      print('========google sign in finish');
                    });
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              FlatButton(
                  onPressed: con.forgotPassword,
                  child: Text(
                    'forgot password',
                    style: TextStyle(fontSize: 15.0),
                  ),
                ),
              FlatButton(
                onPressed: con.signUp,
                child: Text(
                  'No account yet? Sign Up',
                  style: TextStyle(fontSize: 15.0),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _Controller {
  _SignInState state;
  _Controller(this.state);
  String email;
  String password;

    void forgotPassword() {
    Navigator.pushNamed(state.context, ResetPasswordScreen.routeName);
  }

  void signUp() async {
    Navigator.pushNamed(state.context, SignUpScreen.routeName);
  }

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
    if (!state.formKey.currentState.validate()) {
      return;
    }

    state.formKey.currentState.save();

     MyDialog.circularProgressStart(state.context);

    FirebaseUser user;
    try {
      user = await FirebaseController.signIn(email, password);
      print('=======${user.email}');
    } catch (e) {
       MyDialog.circularProgressEnd(state.context);
      MyDialog.info(
        context: state.context,
        title: 'Sign In Error',
        content: e.message ?? e.toString(),
      );
      return;
    }
    Navigator.pushNamed(state.context, HomeScreen.routeName,
        arguments: {'user': user});
  }
}
