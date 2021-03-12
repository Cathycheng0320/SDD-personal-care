import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:personal_care/controller/firebasecontrollor.dart';
import 'package:personal_care/screen/aboutpage_screen.dart';
import 'package:personal_care/screen/addeventpage_screen.dart';
import 'package:personal_care/screen/signin_screen.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/signInScreen/homeScreen';

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<HomeScreen> {
  CalendarController _calendarController = CalendarController();
  _Controller con;
  FirebaseUser user;
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Home'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(user.displayName ?? 'N/A'),
              accountEmail: Text(user.email),
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Sign Out'),
              onTap: con.signOut,
            ),
            ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('About page'),
                onTap: con.about,
              ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Card(
              clipBehavior: Clip.antiAlias,
              margin: const EdgeInsets.all(8.0),
              child: TableCalendar(
                calendarController: _calendarController,
                weekendDays: [6],
                headerStyle: HeaderStyle(
                    decoration: BoxDecoration(
                  color: Colors.red,
                )),
                calendarStyle: CalendarStyle(),
                builders: CalendarBuilders(),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, AddEventPageScreen.routeName);
        },
      ),
    );
  }
}

class _Controller {
  _HomeState state;
  _Controller(this.state);

    void about() {
    Navigator.pushNamed(state.context, AboutPageScreen.routeName);
  }

  void signOut() async {
    try {
      await FirebaseController.signOut();
    } catch (e) {
      print('signOut exception: ${e.message}');
    }
    Navigator.pushReplacementNamed(state.context, SignInScreen.routeName);
  }
}
