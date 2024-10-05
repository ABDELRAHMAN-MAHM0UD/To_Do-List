import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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
        return Slidable(
            // Specify a key if the Slidable is dismissible.
            key: const ValueKey(0),

            // The start action pane is the one at the left or the top side.
            startActionPane: ActionPane(
              extentRatio: 0.25,
              // A motion is a widget used to control how the pane animates.
              motion:  ScrollMotion(),

              // A pane can dismiss the Slidable.
              dismissible: DismissiblePane(onDismissed: () {

              }),

              // All actions are defined in the children parameter.
              children:  [
                // A SlidableAction can have an icon and/or a label.
                SlidableAction(
                  onPressed: (_){
                    Provider.of<TaskProvider>(context, listen: false).deleteTask(
                      tasks[index]
                    );
                  },
                  backgroundColor: Color(0xFFFE4A49),
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
              ],
            ),

            endActionPane:  ActionPane(
              extentRatio: 0.25,
              motion: ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (_){
                    Provider.of<TaskProvider>(context, listen: false).deleteTask(
                        tasks[index]
                    );
                  },
                  backgroundColor: Color(0xFFFE4A49),
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
              ],
            ),

            child:  tasks[index]
          );


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
