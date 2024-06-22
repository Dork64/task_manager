import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/providers/task_provider.dart';
import 'package:task_manager/screens/task_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskProvider(),
      child: Consumer<TaskProvider>(
        builder: (context, taskProvider, child) {
          return MaterialApp(
            title: 'Task Manager',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              brightness: taskProvider.isDarkTheme ? Brightness.dark : Brightness.light,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: TaskListScreen(),
          );
        },
      ),
    );
  }
}
