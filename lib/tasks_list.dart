import 'package:flutter/material.dart';
import 'package:to_do_release/task_widget/task_provider.dart';
import 'package:provider/provider.dart';

import 'colors.dart';

class TasksList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Access the tasks from the TaskProvider
    final tasks = Provider.of<TaskProvider>(context).tasksList;

    return ListView.separated(
      itemBuilder: (context, index) {
        return tasks[index]; // Use the provided tasks
      },
      separatorBuilder: (context, index) => Divider(
        endIndent: 25,
        indent: 25,
        color: AppColors.lightBlue,
        thickness: 1.5,
      ),
      itemCount: tasks.length,
    );
  }
}
