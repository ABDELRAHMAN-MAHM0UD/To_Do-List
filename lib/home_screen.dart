import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/drawer/drawer.dart';
import 'package:to_do_list/task_widget/task_provider.dart';
import 'package:to_do_list/tasks_list.dart';
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
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    // Access the task list from the provider
    final taskProvider = Provider.of<TaskProvider>(context);
    final tasks =
        taskProvider.tasksList; // Assuming 'tasks' is a List<TaskWidget>

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.black,
        leading: Builder(
          // Use Builder to get the correct context for Scaffold
          builder: (context) => IconButton(
            onPressed: () {
              // Open the endDrawer (right-side drawer)
              Scaffold.of(context).openDrawer();
            },
            icon: Icon(Icons.list, color: AppColors.sky, size: 45),
          ),
        ),
        title:
            Text("Tasks", style: TextStyle(color: AppColors.sky, fontSize: 38)),
        toolbarHeight: 110,

      ),
      drawer: Drawer(//width: MediaQuery.of(context).size.width*0.55,
        child: MyDrawer(),
      ),
      backgroundColor: AppColors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: height / 70),
          Expanded(child: TasksList(tasks: tasks,) // Pass the tasks from the provider
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
                  Text("Add new task",
                      style: TextStyle(color: AppColors.sky, fontSize: 28)),
                  Icon(Icons.add_circle_outline_sharp,
                      color: AppColors.sky, size: 50)
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
      isScrollControlled: true, // This ensures the bottom sheet takes full space
      context: context,
      builder: (_) => AddTaskBottomSheet(),
    );
  }

}
