import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/my_theme.dart';
import 'package:to_do_list/tabs/calendar.dart';
import 'package:to_do_list/tabs/themes.dart';
import 'package:to_do_list/tabs/today_tab.dart';
import 'package:to_do_list/task_widget/task_provider.dart';
import 'home_screen.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'theme_preferences.dart'; // Import the ThemePreferences class

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Awesome Notifications
  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelKey: "channelKey",
        channelName: "Notification",
        channelDescription: "Task reminder",
      )
    ],
    debug: true,
  );

  // Initialize Google Mobile Ads
  MobileAds.instance.initialize();

  // Initialize timezone data
  tz.initializeTimeZones();

  // Load the saved theme index
  int savedThemeIndex = await ThemePreferences.loadThemeIndex();

  runApp(
    ChangeNotifierProvider(
      create: (context) => TaskProvider(),
      child: MyApp(savedThemeIndex: savedThemeIndex),
    ),
  );
}

class MyApp extends StatefulWidget {
  final int savedThemeIndex;

  MyApp({required this.savedThemeIndex});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late int currentThemeIndex;

  @override
  void initState() {
    super.initState();
    currentThemeIndex = widget.savedThemeIndex; // Set the initial theme index
  }

  // Function to change the theme and save the index
  void switchTheme(ThemeData newTheme) {
    setState(() {
      currentThemeIndex = MyTheme.themes.indexOf(newTheme);
    });
    ThemePreferences.saveThemeIndex(currentThemeIndex); // Save the new theme index
  }

  @override
  Widget build(BuildContext context) {
    ThemeData currentTheme = MyTheme.themes[currentThemeIndex];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        HomeScreen.routName: (_) => HomeScreen(),
        TodayTab.routName: (_) => TodayTab(),
        Calendar.routName: (_) => Calendar(),
        ThemesTab.routeName: (_) => ThemesTab(
          onThemeChanged: (ThemeData newTheme) {
            switchTheme(newTheme); // Change the theme when a new one is selected
          },
        ),
      },
      initialRoute: HomeScreen.routName,
      theme: currentTheme,
    );
  }
}
