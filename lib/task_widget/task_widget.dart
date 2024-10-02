import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_release/task_widget/task_provider.dart';
import 'package:to_do_release/task_widget/task_widget_view_model.dart';
import 'package:to_do_release/tasks_list.dart';

class TaskWidget extends StatefulWidget {
  String taskTitle;
  late int id; // Ensure the id is properly initialized
  bool isChecked = false; // Start unchecked by default

  TaskWidget({required this.taskTitle, required this.id});

  Map<String, dynamic> toJson() {
    return {
      'title': taskTitle,
      'id': id,
      'isChecked': isChecked, // Save the checked state
    };
  }

  factory TaskWidget.fromJson(Map<String, dynamic> json) {
    return TaskWidget(
      taskTitle: json['title'],
      id: json['id'] ?? 0,
    )..isChecked = json['isChecked'] ?? false; // Restore the checked state
  }

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  TaskManager taskManager = TaskManager();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              widget.taskTitle,
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                decoration: widget.isChecked ? TextDecoration.lineThrough : null,
                decorationColor: Colors.white,
                decorationThickness: 2.5,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                widget.isChecked = true; // Mark task as checked
              });

              // Show the checked state for 2 seconds
              Future.delayed(Duration(seconds: 2), () {
                // Access the TaskProvider to delete the task
                Provider.of<TaskProvider>(context, listen: false).deleteTask(widget);
                setState(() {
                  // You no longer need to update the TasksList directly
                });
              });
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.isChecked ? Colors.green : Colors.transparent,
                border: Border.all(color: Colors.white, width: 1.7),
              ),
              width: width * 0.08,
              child: widget.isChecked
                  ? Icon(Icons.check, size: 35, color: Colors.white)
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
