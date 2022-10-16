import 'package:flutter/material.dart';
import 'package:todo_app/screens/add_note.dart';
import 'package:todo_app/screens/home_page.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Notes',
      // home: HomePage(),
      initialRoute: "/",
      routes: {
        "/":(context) => HomePage(),
        "/add" : (context) => AddNote()
      },
    );
  }
}
