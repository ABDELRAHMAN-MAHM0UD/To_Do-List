import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:to_do_list/task_widget/task_widget.dart';


class TaskProvider with ChangeNotifier {
  List<TaskWidget> _tasksList = [];

  List<TaskWidget> get tasksList => _tasksList;




  Future<void> loadTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? taskListString = prefs.getStringList('taskList');
    if (taskListString != null) {
      _tasksList = taskListString
          .map((taskJson) => TaskWidget.fromJson(jsonDecode(taskJson)))
          .toList();
    }
    notifyListeners(); // Notify listeners of changes
    print(">>>>${tasksList.length}");
  }

  Future<void> addTask(TaskWidget task) async {
    _tasksList.add(task);
    await saveTasks();
    notifyListeners(); // Notify listeners of changes
  }

  Future<void> deleteTask(TaskWidget taskToDelete) async {
    _tasksList.removeWhere((task) => task.id == taskToDelete.id);
    await saveTasks();
    notifyListeners(); // Notify listeners of changes
  }

  Future<void> saveTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> stringList = _tasksList.map((task) => jsonEncode(task.toJson())).toList();
    await prefs.setStringList('taskList', stringList);
  }
}
