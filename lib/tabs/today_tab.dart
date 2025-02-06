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
    double height = MediaQuery.of(context).size.height;


    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          // Use Builder to get the correct context for Scaffold
          builder: (context) => IconButton(
            onPressed: () {
              // Open the endDrawer (right-side drawer)
              Scaffold.of(context).openDrawer();
            },
            icon: Icon(Icons.list, color: Theme.of(context).iconTheme.color, size: 45),
          ),
        ),
        title:
        Text("Today", style: Theme.of(context).textTheme.headlineMedium),
        toolbarHeight: 110,

      ),
      drawer: Drawer(//width: MediaQuery.of(context).size.width*0.55,
        child: MyDrawer(),
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height / 70),
          Expanded(
            child: TasksList(tasks: tasks ?? []), // Pass the tasks
          ),
          Container(
            color: Theme.of(context).colorScheme.surfaceContainer,
            height: height * .1,
            child: InkWell(
              onTap: () {
                AddButtonTap();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("Add new task",
                    style:Theme.of(context).textTheme.titleLarge,),
                  Icon(Icons.add_circle_outline_sharp,
                      color:Theme.of(context).textTheme.titleLarge!.color, size: 50)
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
