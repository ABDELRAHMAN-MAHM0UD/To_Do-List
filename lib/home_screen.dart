import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_release/task_widget/task_provider.dart';
import 'package:to_do_release/task_widget/task_widget.dart';
import 'package:to_do_release/task_widget/task_widget_view_model.dart';
import 'package:to_do_release/tasks_list.dart';
import 'buttom_sheet.dart';
import 'colors.dart';

class HomeScreen extends StatefulWidget {
  static const routName = "HomeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<TaskProvider>(context, listen: false).loadTasks(); // Load tasks
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    // Access the task list from the provider
    final taskProvider = Provider.of<TaskProvider>(context);
    final tasks = taskProvider.tasksList; // Assuming 'tasks' is a List<TaskWidget>

    return Scaffold(
      backgroundColor: AppColors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: height / 12),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Tasks", style: TextStyle(color: AppColors.sky, fontSize: 38)),
              ],
            ),
          ),
          Expanded(
            child: TasksList() // Pass the tasks from the provider
          ),
          Container(
            color: Colors.black38,
            height: height * .1,
            child: InkWell(
              onTap: () {
                AddButtonTap();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("Add new task", style: TextStyle(color: AppColors.sky, fontSize: 28)),
                  Icon(Icons.add_circle_outline_sharp, color: AppColors.sky, size: 50)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void AddButtonTap() {
    showModalBottomSheet(
      context: context,
      builder: (_) => AddTaskBottomSheet(), // No need to pass onTaskAdded
    );
  }

}
