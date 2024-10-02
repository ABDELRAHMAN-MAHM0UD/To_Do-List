import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:to_do_release/task_widget/task_provider.dart';
import 'package:to_do_release/task_widget/task_widget.dart';

class ViewModel {
  var formKey = GlobalKey<FormState>();
  TextEditingController taskTitle = TextEditingController();

  void enterTask(BuildContext context) {
    if (formKey.currentState?.validate() == true) {
      int taskId = DateTime.now().millisecondsSinceEpoch; // Generate a unique ID
      TaskWidget task = TaskWidget(taskTitle: taskTitle.text, id: taskId);

      // Access TaskProvider and add the task
      Provider.of<TaskProvider>(context, listen: false).addTask(task);
      taskTitle.clear(); // Clear the input field
      Navigator.pop(context); // Close the bottom sheet
    }
  }

}
