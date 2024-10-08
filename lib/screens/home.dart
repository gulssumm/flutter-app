import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:myapp/constants/color.dart';
import 'package:myapp/constants/tasktype.dart';
import 'package:myapp/model/task.dart';
import 'package:myapp/screens/add_new_task.dart';
import 'package:myapp/service/todo_service.dart';
import 'package:myapp/todoitem.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //List<String> todo = ["Study lessons", "Run 5K", "Go to party"];
  //List<String> completed = ["Game meetup", "Take out thrash"];
  List<Task> todo = [
    Task(
      type: Tasktype.note,
      title: "Study Lessons",
      description: "Study COMP117",
      isCompleted: false,
    )
  ];

  void addNewTask(Task newTask) {
    setState(() {
      todo.add(newTask);
    });
  }

  @override
  Widget build(BuildContext context) {
    TodoService todoService = TodoService();

    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          backgroundColor: HexColor(backgroundcolor),
          body: Column(children: [
            // Header
            Container(
              width: deviceWidth,
              height: deviceHeight / 3,
              // color: Colors.purple,
              decoration: const BoxDecoration(
                  color: Colors.purple,
                  image: DecorationImage(
                      image: AssetImage("lib/assets/images/header.png"),
                      fit: BoxFit.cover)),
              child: const Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text(
                      "October 20, 2022",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: Text(
                      "My Todo List",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            // Top Column
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: SingleChildScrollView(
                  child: FutureBuilder(
                      future: todoService.getTodos(),
                      builder: (context, snapshot) {
                        if (snapshot.data == null) {
                          return const CircularProgressIndicator();
                          // loading symbol will show
                        } else {
                          return ListView.builder(
                            primary: false,
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return TodoItem(
                                task: snapshot.data![index],
                              );
                            },
                          );
                        }
                      }),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AddNewTaskScreen(
                    addNewTask: (newTask) => addNewTask(newTask),
                  ),
                ));
              },
              child: const Text("Add new task"),
            )
          ]),
        ),
      ),
    );
  }
}
