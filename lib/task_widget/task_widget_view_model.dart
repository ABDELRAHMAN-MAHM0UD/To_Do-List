import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:to_do_release/task_widget/task_widget.dart';

class TaskManager {
  static const String taskListKey = 'taskList';

  Future<void> saveTaskList(List<TaskWidget> tasks) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> stringList = tasks.map((task) => jsonEncode(task.toJson())).toList();
    await prefs.setStringList(taskListKey, stringList);
  }

  Future<List<TaskWidget>> loadTaskList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? taskListString = prefs.getStringList(taskListKey);
    if (taskListString != null) {
      // Corrected to use fromJson
      return taskListString.map((taskJson) => TaskWidget.fromJson(jsonDecode(taskJson))).toList();
    }
    return [];
  }

  Future<void> deleteTask(TaskWidget taskToDelete) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? taskListString = prefs.getStringList(taskListKey);

    if (taskListString != null) {
      List<TaskWidget> tasks = taskListString
          .map((taskJson) => TaskWidget.fromJson(jsonDecode(taskJson)))
          .toList();

      tasks.removeWhere((task) => task.id == taskToDelete.id); // Match by 'id'

      // Save the updated list
      List<String> updatedStringList = tasks.map((task) => jsonEncode(task.toJson())).toList();
      await prefs.setStringList(taskListKey, updatedStringList);
    }
  }

}
