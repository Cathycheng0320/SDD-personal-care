// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:personal_care/model/app_event.dart';


// class EventDetails extends StatelessWidget {
// static const routeName = '/homeScreen/eventDetails';
//   final AppEvent event;

//   const EventDetails({Key key, this.event}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: ListView(
//         padding: const EdgeInsets.all(16.0),
//         children: <Widget>[
//           ListTile(
//             title: Text(event.title, style: Theme.of(context)
//             .textTheme.headline5,),
//             subtitle: Text(DateFormat("EEEE, dd MMMM, yyyy")
//             .format(event.date)),
//           ),
//           const SizedBox(height: 10.0,),
//           if(event.description != null )
//           ListTile(
//             title: Text(event.description),
//           ),
//           const SizedBox(height: 20.0,)
//           ],
//       ),
//     );
//   }
// }
