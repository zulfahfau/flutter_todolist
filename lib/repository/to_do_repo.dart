import 'package:to_do_list/model/to_do.dart';

class ToDoRepository {
  List<ToDo> todos = <ToDo>[];

  addToDo(ToDo newToDo) {
    todos.add(newToDo);
  }

  List<ToDo> getListToDo() {
    return todos;
  }
}
