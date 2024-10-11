import 'package:flutter/material.dart';
import 'package:to_do_list/home_screen.dart';

import '../colors.dart';
import '../tabs/today_tab.dart';

class MyDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.Blue,AppColors.darkblue,
            AppColors.black,], // Specify your gradient colors here
          begin: Alignment.topCenter, // Gradient start point
          end: Alignment.bottomCenter, // Gradient end point
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Column(mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextButton(onPressed: (){
              Navigator.pushNamed(context, TodayTab.routName);
            },
                child: Text("Today Tasks",
                  style: Theme.of(context).textTheme.bodyLarge,),),
            TextButton(onPressed: (){
              Navigator.pushNamed(context, HomeScreen.routName);
            },
                child: Text("All Tasks",
                    style: Theme.of(context).textTheme.bodyLarge)),
            TextButton(onPressed: (){},
                child: Text("Calender",
                    style: Theme.of(context).textTheme.bodyLarge)),
          ],
        ),
      ),
    );
  }
}
