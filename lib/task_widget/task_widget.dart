import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_release/task_widget/task_provider.dart';
import 'package:to_do_release/task_widget/task_widget_view_model.dart';
import 'package:to_do_release/tasks_list.dart';

class TaskWidget extends StatefulWidget {
  String taskTitle;
  DateTime dateTime = DateTime.now();
  late int id; // Ensure the id is properly initialized
  bool isChecked = false; // Start unchecked by default

  TaskWidget({required this.taskTitle, required this.id,required this.dateTime});

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
            ? DateTime.parse(json['dateTime']) // Ensure DateTime is parsed correctly
            : DateTime.now(),
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
    return InkWell(
      onTap: ()=> print("<<<<<<<<<<<<<${widget.dateTime}>>>>>>>>>>>>>>"),
      child: Container(
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
              },
              child: Container(
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
      ),
    );
  }
}
