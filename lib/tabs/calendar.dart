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
        Text("Calendar", style: Theme.of(context).textTheme.headlineMedium),
        toolbarHeight: 110,

      ),
      drawer: Drawer(//width: MediaQuery.of(context).size.width*0.55,
        child: MyDrawer(),
      ),
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
            headerProps: EasyHeaderProps(
              monthStyle: TextStyle(color: Theme.of(context).textTheme.headlineSmall!.color,fontSize: 18),
              selectedDateStyle: TextStyle(color: Theme.of(context).textTheme.headlineSmall!.color,fontSize: 18),
              monthPickerType: MonthPickerType.switcher,
              dateFormatter: DateFormatter.fullDateDMY(),
            ),
            dayProps:  EasyDayProps(
              inactiveDayStyle:
                  DayStyle(dayStrStyle: TextStyle(color: Theme.of(context).textTheme.headlineSmall!.color),
                      dayNumStyle:TextStyle(color: Theme.of(context).textTheme.headlineSmall!.color),
                /*  monthStrStyle:TextStyle(color: Colors.white),*/ ),
              dayStructure: DayStructure.dayStrDayNum,
              activeDayStyle: DayStyle(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Theme.of(context).colorScheme.tertiary,
                      Theme.of(context).colorScheme.onTertiary,
                      Theme.of(context).colorScheme.onTertiaryFixed
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
