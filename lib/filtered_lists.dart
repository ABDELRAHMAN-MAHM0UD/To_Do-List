import 'package:provider/provider.dart';
import 'package:to_do_list/task_widget/task_provider.dart';
import 'package:to_do_list/task_widget/task_widget.dart';

class FilteredLists{
 TaskProvider taskProvider ;
 List<TaskWidget>? todayTasks;
 
FilteredLists({required this.taskProvider});
  void getTodayTasks() {
  todayTasks = taskProvider.tasksList.where((task) {
    return task.dateTime.year == DateTime.now().year &&
        task.dateTime.month == DateTime.now().month &&
        task.dateTime.day == DateTime.now().day;
  },).toList();
 }
}