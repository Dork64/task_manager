import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/models/task.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];
  bool _isDarkTheme = false;

  List<Task> get tasks => _tasks;
  bool get isDarkTheme => _isDarkTheme;

  TaskProvider() {
    loadTasks();
    loadThemePreference();
  }

  Future<void> loadTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tasksString = prefs.getString('tasks');
    if (tasksString != null) {
      _tasks = (json.decode(tasksString) as List)
          .map((taskJson) => Task.fromJson(taskJson))
          .toList();
      notifyListeners();
    }
  }

  Future<void> saveTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('tasks', json.encode(_tasks));
  }

  void addTask(Task task) {
    _tasks.add(task);
    saveTasks();
    notifyListeners();
  }

  void updateTask(Task task) {
    int index = _tasks.indexWhere((t) => t.id == task.id);
    if (index >= 0) {
      _tasks[index] = task;
      saveTasks();
      notifyListeners();
    }
  }

  void deleteTask(String id) {
    _tasks.removeWhere((task) => task.id == id);
    saveTasks();
    notifyListeners();
  }

  Future<void> fetchTasksFromNetwork(BuildContext context) async {
    try {
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));
      if (response.statusCode == 200) {
        List<Task> newTasks = (json.decode(response.body) as List)
            .map((taskJson) => Task.fromJson(taskJson))
            .toList();

        _tasks.addAll(newTasks);

        saveTasks();
        notifyListeners();
      } else {
        throw Exception('Не удалось загрузить задачи: ${response.statusCode}');
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Ошибка!'),
            content: Text('Не удалось загрузить задачи: $e'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }


  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    saveThemePreference();
    notifyListeners();
  }

  Future<void> loadThemePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isDarkTheme = prefs.getBool('isDarkTheme') ?? false;
    notifyListeners();
  }

  Future<void> saveThemePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkTheme', _isDarkTheme);
  }
}
