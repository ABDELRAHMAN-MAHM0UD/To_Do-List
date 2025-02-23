import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/filtered_lists.dart';
import 'package:to_do_list/task_widget/task_provider.dart';
import 'package:to_do_list/task_widget/task_widget_view_model.dart';

class TaskWidget extends StatefulWidget {
  String taskTitle;
  DateTime dateTime = DateTime.now();
  late int id; // Ensure the id is properly initialized
  bool isChecked = false; // Start unchecked by default

  TaskWidget(
      {required this.taskTitle,
      required this.id,
      required this.dateTime,
      this.isChecked = false});

  Map<String, dynamic> toJson() {
    return {
      'title': taskTitle,
      'id': id,
      'dateTime': dateTime.toIso8601String(),
      'isChecked': isChecked, // Save the checked state
    };
  }

  factory TaskWidget.fromJson(Map<String, dynamic> json) {
    return TaskWidget(
        taskTitle: json['title'],
        dateTime: json['dateTime'] != null
            ? DateTime.parse(
                json['dateTime']) // Ensure DateTime is parsed correctly
            : DateTime.now(),
        id: json['id'] ?? 0,
        isChecked: json['isChecked']); // Restore the checked state
  }

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  TaskManager taskManager = TaskManager();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var provider = Provider.of<TaskProvider>(context);
    return InkWell(
      onTap: () {
        FilteredLists filteredLists = FilteredLists(taskProvider: provider);
        filteredLists.getTodayTasks();
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        constraints: BoxConstraints(minHeight: 70),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                widget.taskTitle,
                style: TextStyle(
                  color: Theme.of(context).textTheme.headlineSmall!.color,
                  fontSize: 28,
                  decoration:
                      widget.isChecked ? TextDecoration.lineThrough : null,
                  decorationColor: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .decorationColor,
                  decorationThickness: 2.5,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  widget.isChecked = true; // Mark task as checked
                  provider.saveTasks();
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.isChecked ? Colors.green : Colors.transparent,
                  border: Border.all(
                      color: Theme.of(context).colorScheme.onSurface, width: 1.7),
                ),
                width: width * 0.08,
                height: height * 0.08,
                child: widget.isChecked
                    ? Icon(Icons.check, size: 35, color: Colors.white)
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
