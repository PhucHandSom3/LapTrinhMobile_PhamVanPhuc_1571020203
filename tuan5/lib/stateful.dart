import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class TaskManager {
  List<String> tasks = [];

  void addTask(String task) {
    tasks.add(task);
  }

  int getTaskCount() {
    return tasks.length;
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TaskManager taskManager = TaskManager();

  @override
  Widget build(BuildContext context) {
    taskManager.addTask('Task 1');
    taskManager.addTask('Task 2');
    taskManager.addTask('Task 3');
    int taskCount = taskManager.getTaskCount();

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Task Manager'),
        ),
        body: Center(
          child: Text(
            'Number of tasks: $taskCount',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}