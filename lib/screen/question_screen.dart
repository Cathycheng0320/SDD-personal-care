
import 'package:flutter/material.dart';

class QuestionScreen extends StatefulWidget {
  
  static const routeName = 'aboutPageScreen/QuestionScreen';
  @override
  State<StatefulWidget> createState() {
    return _QuestionState();
  }
}

class _QuestionState extends State<QuestionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ask Question'),
    ),
    body: Text('Ask user for personal information'),
    );
  }
}
