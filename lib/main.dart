import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:myapp/constants/color.dart';
import 'package:myapp/todoitem.dart';

void main() {
  // Firebase
  // ...
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

List<String> todo = ["Study lessons", "Run 5K", "Go to party"];
List<String> completed = ["Game meetup", "Take out thrash"];

class _MyAppState extends State<MyApp> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
                  child: ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: todo.length,
                    itemBuilder: (context, index) {
                      return TodoItem(
                        title: todo[index],
                      );
                    },
                  ),
                ),
              ),
            ),
            // Completed Text
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Completed",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  )),
            ),
            // Buttom Column
            Expanded(
                child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: SingleChildScrollView(
                child: ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: completed.length,
                    itemBuilder: (context, index) {
                      return TodoItem(title: completed[index]);
                    }),
              ),
            )),
            ElevatedButton(onPressed: () {}, child: const Text("Add new task"))
          ]),
        ),
      ),
    );
  }
}
