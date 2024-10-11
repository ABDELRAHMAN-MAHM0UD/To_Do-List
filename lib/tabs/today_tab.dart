import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/drawer/drawer.dart';
import 'package:to_do_list/filtered_lists.dart';
import 'package:to_do_list/task_widget/task_provider.dart';
import 'package:to_do_list/tasks_list.dart';

import '../buttom_sheet.dart';
import '../colors.dart';

class TodayTab extends StatefulWidget {
  static const routName = "today_tab";

  @override
  State<TodayTab> createState() => _TodayTabState();
}

class _TodayTabState extends State<TodayTab> {
  late FilteredLists filteredLists;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Access the provider here
    var provider = Provider.of<TaskProvider>(context);
    filteredLists = FilteredLists(taskProvider: provider);
    filteredLists.getTodayTasks(); // Populate the todayTasks
  }

  @override
  Widget build(BuildContext context) {
    final tasks = filteredLists.todayTasks;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.black,
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: Icon(Icons.list, color: AppColors.sky, size: 45),
          ),
        ),
        title:
            Text("Today", style: TextStyle(color: AppColors.sky, fontSize: 38)),
        toolbarHeight: 110,
      ),
      drawer: Drawer(child: MyDrawer()),
      backgroundColor: AppColors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height / 70),
          Expanded(
            child: TasksList(tasks: tasks ?? []), // Pass the tasks
          ),
          Container(
            color: Colors.black38,
            height: MediaQuery.of(context).size.height * .1,
            child: InkWell(
              onTap: AddButtonTap,
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
      isScrollControlled: true,
      context: context,
      builder: (_) => AddTaskBottomSheet(),
    );
  }
}
