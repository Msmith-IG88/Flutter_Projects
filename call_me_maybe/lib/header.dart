import 'package:flutter/material.dart';
import 'background.dart';

class MyApp extends StatelessWidget {
  final String title;

  const MyApp({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Week 4',
      theme: ThemeData(primarySwatch: Colors.lightGreen),
      home: MainTabs(title: title),
    );
  }
}
