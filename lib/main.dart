import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_release/task_widget/task_provider.dart';

import 'home_screen.dart';

void main(){
  runApp(
    ChangeNotifierProvider(
      create: (context) => TaskProvider(), // Initialize TaskProvider
      child: MyApp(),
    ),
  );}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }

}