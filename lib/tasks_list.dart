import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/task_widget/task_provider.dart';
import 'package:to_do_list/task_widget/task_widget.dart';

import 'colors.dart';

class TasksList extends StatefulWidget {

  List<TaskWidget> tasks;

  TasksList({required this.tasks});
  @override
  State<TasksList> createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  @override
  Widget build(BuildContext context) {
    // Access the tasks from the TaskProvider
   // final tasks = Provider.of<TaskProvider>(context).tasksList;

    return ListView.separated(
      itemBuilder: (context, index) {
        return Slidable(
          key: ValueKey(widget.tasks[index].id), // Ensure each Slidable has a unique key

          // Start action pane
          startActionPane: ActionPane(
            extentRatio: 0.25,
            motion: ScrollMotion(),
            dismissible: DismissiblePane(
              onDismissed: () {
                // Remove the task via the Provider
                Provider.of<TaskProvider>(context, listen: false).deleteTask(
                  widget.tasks[index],
                );
              },
            ),
            children: [
              SlidableAction(
                onPressed: (_) {
                  Provider.of<TaskProvider>(context, listen: false).deleteTask(
                    widget.tasks[index],
                  );
                },
                backgroundColor: Color(0xFFFE4A49),
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
              ),
            ],
          ),

          // End action pane
          endActionPane: ActionPane(
            extentRatio: 0.25,
            motion: ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (_) {
                  Provider.of<TaskProvider>(context, listen: false).deleteTask(
                    widget.tasks[index],
                  );
                },
                backgroundColor: Color(0xFFFE4A49),
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
              ),
            ],
          ),

          // The child widget
          child: widget.tasks[index], // Ensure this is a widget that can be displayed
        );



      },
      separatorBuilder: (context, index) => Divider(
        endIndent: 25,
        indent: 25,
        color: AppColors.lightBlue,
        thickness: 1.5,
      ),
      itemCount:  widget.tasks.length,
    );
  }
}
