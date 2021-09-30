import 'package:flutter/material.dart';
import 'package:to_do_list/model/to_do.dart';
import 'package:to_do_list/repository/to_do_repo.dart';
import '/widget/text_field_widget.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'to_do_detail.dart';

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({Key? key}) : super(key: key);

  @override
  _ToDoScreenState createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  ToDoRepository _toDoRepository = ToDoRepository();
  TextEditingController toDoName = new TextEditingController();
  TextEditingController toDoDesc = new TextEditingController();
  TextEditingController toDoTime = new TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  deleteToDo(index) {
    setState(() {
      _toDoRepository.getListToDo().removeWhere((item) => item.id == index);
    });
  }

  Widget textFormField(TextEditingController controller, String str) {
    return TextFormField(
        controller: controller,
        decoration: InputDecoration(hintText: 'Enter Your ' + str),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your ' + str;
          } else {
            return null;
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("To Do List"),
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFieldWidget(
                        con: toDoName,
                        hint: "Enter your to do",
                        validate: MultiValidator([
                          RequiredValidator(
                              errorText: "Please enter your to do"),
                          MinLengthValidator(5,
                              errorText: "Must be at least 5 char"),
                        ]),
                      ),
                      TextFieldWidget(
                        con: toDoDesc,
                        hint: "Enter your to do description",
                        validate: MultiValidator([
                          RequiredValidator(
                              errorText: "Please enter your to do description"),
                          MinLengthValidator(5,
                              errorText: "Must be at least 5 char"),
                        ]),
                      ),
                      TextFieldWidget(
                        con: toDoTime,
                        hint: "Enter your to do time",
                        validate: MultiValidator([
                          RequiredValidator(
                              errorText: "Please enter your to do time"),
                          MinLengthValidator(5,
                              errorText: "Must be at least 5 char"),
                        ]),
                      ),
                      // textFormField(toDoName, 'To Do'),
                      // textFormField(toDoDesc, 'Description'),
                      // textFormField(toDoTime, 'Time'),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  _toDoRepository.addToDo(new ToDo(
                                      _toDoRepository.getListToDo().length + 1,
                                      toDoName.text,
                                      toDoDesc.text,
                                      toDoTime.text));
                                });
                              }
                            },
                            child: Text('Submit')),
                      ),
                    ],
                  )),
            ),
            SizedBox(height: 50.0),
            Expanded(
              child: Card(
                  child: Scrollbar(
                      child: ListView.builder(
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                ListTile(
                                  leading: Icon(Icons.date_range),
                                  title: Text(
                                    _toDoRepository
                                        .getListToDo()[index]
                                        .toDoName,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  onTap: () {
                                    //Navigator.pushNamed(context, '/detail');
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ToDoDetail(),
                                            settings: RouteSettings(
                                              arguments: _toDoRepository
                                                  .getListToDo()[index],
                                            )));
                                  },
                                  trailing: IconButton(
                                      onPressed: () {
                                        deleteToDo(_toDoRepository
                                            .getListToDo()[index]
                                            .id);
                                      },
                                      icon: const Icon(Icons.delete)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        color: Colors.cyan,
                        thickness: 2,
                      )
                    ],
                  );
                },
                itemCount: _toDoRepository.getListToDo().length,
              ))),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Column(
            //     children: todos.map((e) => new Text(e)).toList(),
            //   ),
            // ),
          ],
        ),
      ),
    ));
  }
}
