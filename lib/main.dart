import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/task_widget/task_provider.dart';
import 'home_screen.dart';
import 'package:timezone/data/latest.dart' as tz;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
            channelKey: "channelKey",
            channelName: "Notification",
            channelDescription: "Task reminder")
      ],
  debug: true);
  MobileAds.instance.initialize();
  tz.initializeTimeZones(); // Initialize timezone data

  runApp(
    ChangeNotifierProvider(create: (context) => TaskProvider(),
      child: MyApp(),
    ),
  );

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
