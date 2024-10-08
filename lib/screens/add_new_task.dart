import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:myapp/constants/color.dart';
import 'package:myapp/constants/tasktype.dart';
import 'package:myapp/model/task.dart';
import 'package:myapp/model/todo.dart';
import 'package:myapp/service/todo_service.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key, required this.addNewTask});
  // Passing function as parameter
  final void Function(Task newTask) addNewTask;

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController useridController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  Tasktype taskType = Tasktype.note;
  TodoService todoService = TodoService();

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor(backgroundcolor),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  width: deviceWidth,
                  height: deviceHeight / 10,
                  decoration: const BoxDecoration(
                    color: Colors.purple,
                    image: DecorationImage(
                      image: AssetImage(
                          "lib/assets/images/add_new_task_header.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(
                            Icons.close,
                            size: 40,
                            color: Colors.white,
                          )),
                      const Expanded(
                          child: Text(
                        "Add New Task",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 21),
                        textAlign: TextAlign.center,
                      ))
                    ],
                  )),
              const Padding(
                  padding: EdgeInsets.only(top: 10), child: Text("Task title")),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                      filled: true, fillColor: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    const Text("Category"),
                    GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            duration: Duration(milliseconds: 300),
                            content: Text("Category selected"),
                          ),
                        );
                        setState(() {
                          taskType = Tasktype.note;
                        });
                      },
                      child: Image.asset("lib/assets/images/category_1.png"),
                    ),
                    GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            duration: Duration(milliseconds: 300),
                            content: Text("Category selected"),
                          ),
                        );
                        setState(() {
                          taskType = Tasktype.calendar;
                        });
                      },
                      child: Image.asset("lib/assets/images/category_2.png"),
                    ),
                    GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            duration: Duration(milliseconds: 300),
                            content: Text("Category selected"),
                          ),
                        );
                        setState(() {
                          taskType = Tasktype.contest;
                        });
                      },
                      child: Image.asset("lib/assets/images/category_3.png"),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          const Text("User Id"),
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: TextField(
                                controller: useridController,
                                decoration: const InputDecoration(
                                    filled: true, fillColor: Colors.white),
                              ))
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          const Text("Time"),
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: TextField(
                                controller: timeController,
                                decoration: const InputDecoration(
                                    filled: true, fillColor: Colors.white),
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text("Description"),
              ),
              SizedBox(
                height: 300,
                child: TextField(
                  controller: descriptionController,
                  expands: true,
                  maxLines: null,
                  decoration: const InputDecoration(
                      filled: true, fillColor: Colors.white, isDense: true),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    saveTodo();
                    Navigator.pop(context);
                  },
                  child: const Text("Save"))
            ],
          ),
        ),
      ),
    );
  }

  void saveTodo() {
    Todo newTodo = Todo(
      id: -1,
      todo: titleController.text,
      completed: false,
      userId: int.parse(useridController.text),
    );
    todoService.addTodo(newTodo);
  }
}
