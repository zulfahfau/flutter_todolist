import 'package:flutter/material.dart';
import 'package:to_do_list/model/to_do.dart';
import 'to_do_screen.dart';

class ToDoDetail extends StatelessWidget {
  ToDoDetail({Key? key}) : super(key: key);
  //ngirim data
  // final ToDo toDo;

  @override
  Widget build(BuildContext context) {
    final todo = ModalRoute.of(context)?.settings.arguments as ToDo;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(todo.toDoName),
      ),
      body: Container(
        child: Column(
          children: [
            Text(todo.toDoDesc),
            Text(todo.toDoTime),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('BACK'))
          ],
        ),
      ),
    ));
  }
}
