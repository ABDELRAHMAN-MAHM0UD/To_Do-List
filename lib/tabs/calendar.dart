import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/drawer/drawer.dart';
import 'package:to_do_list/filtered_lists.dart';
import 'package:to_do_list/task_widget/task_provider.dart';
import 'package:to_do_list/tasks_list.dart';

import '../buttom_sheet.dart';
import '../colors.dart';

class Calendar extends StatefulWidget {
  static const routName = "Calendar";

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late FilteredLists filteredLists;


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Access the provider here
    var provider = Provider.of<TaskProvider>(context);
    filteredLists = FilteredLists(taskProvider: provider);
    filteredLists.getTaskByDate(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    final tasks = filteredLists.tasksByDate;

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
        title: Text("Calendar",
            style: TextStyle(color: AppColors.sky, fontSize: 38)),
        toolbarHeight: 110,
      ),
      drawer: Drawer(child: MyDrawer()),
      backgroundColor: AppColors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height / 70),

          EasyDateTimeLine(
            initialDate: DateTime.now(),
            onDateChange: (selectedDate) {
              filteredLists.getTaskByDate(selectedDate);
              setState(() {

              });
            },
            headerProps: const EasyHeaderProps(
              monthStyle: TextStyle(color: Colors.white,fontSize: 18),
              selectedDateStyle: TextStyle(color: Colors.white,fontSize: 18),
              monthPickerType: MonthPickerType.switcher,
              dateFormatter: DateFormatter.fullDateDMY(),
            ),
            dayProps: const EasyDayProps(
              inactiveDayStyle:
                  DayStyle(dayStrStyle: TextStyle(color: Colors.white),
                      dayNumStyle:TextStyle(color: Colors.white),
                  monthStrStyle:TextStyle(color: Colors.white), ),
              dayStructure: DayStructure.dayStrDayNum,
              activeDayStyle: DayStyle(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xff3371FF),
                      Color(0xff8426D6),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 50),

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
