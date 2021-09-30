import 'package:flutter/material.dart';
import 'presentation/to_do_screen.dart';
import 'presentation/to_do_detail.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: ToDoScreen(),
      routes: {
        '/': (context) => ToDoScreen(),
        //'/detail' : (context) => ToDoDetail()
      },
    );
  }
}
